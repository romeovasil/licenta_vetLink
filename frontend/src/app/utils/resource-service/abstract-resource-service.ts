/*
 * Copyright (c) 2018 Well Solutions SRL. All Rights Reserved.
 * This software is the proprietary information of Well Solutions SRL.
 * Use is subject to license and non-disclosure terms
 */

import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
const headers = new HttpHeaders()
  .set('content-type', 'application/json')
  .set('Access-Control-Allow-Origin', '*');
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
    const token = localStorage.getItem("token");
    const authHeaders = headers.set('Authorization', `Bearer ${token}`);
    return this.httpClient.get(`http://localhost:8080/api/v1/${this.url}`, {headers:authHeaders})
  }

  save(resource: D) {
    const token = localStorage.getItem("token");
    const authHeaders = headers.set('Authorization', `Bearer ${token}`);
    return this.httpClient.post(`http://localhost:8080/api/v1/${this.url}`, resource,{headers:authHeaders})
  }




}
