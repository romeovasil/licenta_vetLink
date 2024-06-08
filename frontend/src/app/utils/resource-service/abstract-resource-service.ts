import {HttpClient, HttpHeaders} from '@angular/common/http';
import {Injectable} from '@angular/core';

@Injectable()
export abstract class AbstractResourceService<D> {
  protected url;
  protected httpClient;
  protected headers = new HttpHeaders({
    'Content-Type': 'application/json; charset=utf-8',
  });

  constructor(
    http: HttpClient,
    url: string,
  ) {
    this.httpClient = http;
    this.url = url;

  }

  findAll() {
    return this.httpClient.get(`http://localhost:8080/api/v1/${this.url}`, {headers:this.getHeaders()})
  }

  save(resource: D) {
    return this.httpClient.post(`http://localhost:8080/api/v1/${this.url}`, resource,{headers:this.getHeaders()})
  }

  edit(resource: D) {
    return this.httpClient.put(`http://localhost:8080/api/v1/${this.url}`, resource,{headers:this.getHeaders()})
  }

  delete(id: Number) {
    return this.httpClient.delete(`http://localhost:8080/api/v1/${this.url}/${id}`,{headers:this.getHeaders()})
  }


  getHeaders(){
    const token = localStorage.getItem("token");
    return this.headers.set('Authorization', `Bearer ${token}`)
  }
}
