package com.romeo.VetLink.config;

import com.romeo.VetLink.user.User;
import com.romeo.VetLink.user.UserJpaRepository;
import com.romeo.VetLink.vetClinic.domain.VetClinic;
import com.romeo.VetLink.vetClinic.domain.VetClinicJpaRepository;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.security.Key;
import java.util.*;
import java.util.function.Function;

@Service
public class JWTService {
    private static final String SECRET_KEY="404E635266556A586E3272357538782F413F4428472B4B6250645367566B5970";
    private final VetClinicJpaRepository vetClinicJpaRepository;
    private final UserJpaRepository userJpaRepository;

    public JWTService(VetClinicJpaRepository vetClinicJpaRepository, UserJpaRepository userJpaRepository) {
        this.vetClinicJpaRepository = vetClinicJpaRepository;
        this.userJpaRepository = userJpaRepository;
    }


    public String extractUsername(String token) {
        return extractClaim(token,Claims::getSubject);
    }
    public<T> T extractClaim(String token, Function<Claims,T> claimsResolver){
        final Claims claims = extractAllClaims(token);
        return claimsResolver.apply(claims);
    }

    public String generateToken(UserDetails userDetails){
        return generateToken(new HashMap<>(), userDetails);
    }
    public String generateToken(Map<String,Object> extraClaims, UserDetails userDetails){
            Optional<User> user = userJpaRepository.findByEmail(userDetails.getUsername());
            List<VetClinic> vetClinicList = null;
            if(user.isPresent()){
                 vetClinicList = vetClinicJpaRepository.findAllByOwner(user.get().getId());
            }


            extraClaims.put("vetClinic",vetClinicList);

            return Jwts.builder().setClaims(extraClaims).setSubject(userDetails.getUsername())
                    .setIssuedAt(new Date(System.currentTimeMillis()))
                    .setExpiration(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 2))
                    .signWith(getSignInKey(), SignatureAlgorithm.HS256)
                    .compact();
    }

    public boolean isTokenValid(String token, UserDetails userDetails){
        final String username = extractUsername(token);
        return (username.equals(userDetails.getUsername())) && !isTokenExpired(token);
    }

    private boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }

    private Date extractExpiration(String token) {
        return extractClaim(token,Claims::getExpiration);
    }

    private Claims extractAllClaims(String token){
        return Jwts.parserBuilder()
                .setSigningKey(getSignInKey())
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    private Key getSignInKey() {
        byte[] keyBytes = Decoders.BASE64.decode(SECRET_KEY);
        return Keys.hmacShaKeyFor(keyBytes);
    }

}
