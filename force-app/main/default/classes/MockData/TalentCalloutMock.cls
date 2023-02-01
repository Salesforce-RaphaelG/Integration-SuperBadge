@isTest
global with sharing class TalentCalloutMock implements HttpCalloutMock {
  global HTTPResponse respond(HTTPRequest request) {
    HttpResponse response = new HttpResponse();
    response.setHeader('Content-Type', 'application/json;charset=UTF-8');
    response.setBody(
      '{"statusMsg" : "message recieved","statusCode" : "200","status" : "success"}'
    );
    response.setStatusCode(200);
    return response;
  }
}
