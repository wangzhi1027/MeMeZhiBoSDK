//
//  HttpClientSyn.m
//  TTShow
//
//  Created by twb on 13-6-23.
//  Copyright (c) 2013年 twb. All rights reserved.
//
#import "HttpClientSyn.h"

@implementation NSMutableURLRequest (TTShow)

+ (NSMutableURLRequest *)GETRequestForURL:(NSString *) url
{
	return [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
}

+ (NSMutableURLRequest *)POSTRequestForURL:(NSString *) url
{
	NSMutableURLRequest *r = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	[r setHTTPMethod:@"POST"];
	return r;
}

+ (NSMutableURLRequest *)POSTRequestForURL:(NSString *) url
							   withJSONData:(NSData *) data
{
	NSMutableURLRequest *r = [NSMutableURLRequest POSTRequestForURL:url];
	if(data)
    {
		[r setHTTPBody:data];
		[r setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
		[r setValue:[@(data.length) stringValue] forHTTPHeaderField:@"Content-Length"];
	}
	return r;
}

+ (NSMutableURLRequest *)POSTRequestForURL:(NSString *) url
							   withImageData:(NSData *) data
{
	NSMutableURLRequest *r = [NSMutableURLRequest POSTRequestForURL:url];
	if(data)
    {
		[r setHTTPBody:data];
		[r setValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
		[r setValue:[@(data.length) stringValue] forHTTPHeaderField:@"Content-Length"];
	}
	return r;
}

@end

@implementation HttpClientSyn
{
	NSError *_error;
	NSURLConnection *_conn;
	NSMutableData *_data_buf;
	NSMutableDictionary *_headers;
	NSThread *_thread;
}

- (id)init
{
	self = [super init];
	if(self)
    {
		_conn = nil;
		_error = nil;
		_headers = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void)dealloc
{
	[_error release];
	[_headers release];
	[super dealloc];
}

- (void)setValue:(NSString *)value forHttpHeader:(NSString *)field
{
	[_headers setValue:value forKey:field];
}

- (void)removeHttpHeader:(NSString *)field
{
	[_headers removeObjectForKey:field];
}

- (void)removeAllHttpHeaders
{
	[_headers removeAllObjects];
}

- (NSData *)getFromURL:(NSString *)url
{
	NSURLRequest *req = [self requestForURL:url withMehtod:@"GET"];
	[self sendRequest:req];
	[self waitForFinishingLoading];
	return [self dataToReturn];
}

- (NSData *)postData:(NSData *)data toURL:(NSString *)url
{
	NSMutableURLRequest *req = [self requestForURL:url withMehtod:@"POST"];
	if(data)
		[req setHTTPBody:data];
	[self sendRequest:req];
	[self waitForFinishingLoading];
	return [self dataToReturn];
}

- (NSError *)lastError
{
	return _error;
}

// Helper methods
- (NSMutableURLRequest *) requestForURL:(NSString *)url withMehtod:(NSString *)method
{
	assert(url&&method);
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	req.HTTPMethod = method;
	if(_headers.count > 0)
    {
        [req setAllHTTPHeaderFields:_headers];
    }
	return req;
}

- (NSData *)sendRequest:(NSURLRequest *)request
{
	[self connect:request];
	[self waitForFinishingLoading];
	return [self dataToReturn];
}


- (id)sendRequestForJSONResponse:(NSURLRequest *)request
{
	NSData *data = [self sendRequest:request];
	id resp = nil;
	if(data && data.length > 0)
    {
		NSError *error = nil;
		resp = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
		if(!resp)
        {
        }
	}
	return resp;
}

- (void)connect:(NSURLRequest *)request
{
	[_error release];
	_error = nil;
	self.lastStatusCode = 0;
	assert(_data_buf == nil);
	_data_buf = [[NSMutableData alloc] initWithCapacity:256];
	_conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	if(!_conn)
    {
        [self stopWithError:[NSError errorWithDomain:@"TTShow" code:0 userInfo:nil]];
    }
		
}

- (void)stopWithError:(NSError *)error
{
	if(error)
    {
		[_error release];
		_error = [error copy];
	}
	[_conn release];
	_conn = nil;
}

- (void)waitForFinishingLoading
{
	while (_conn)
    {
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5f]];
	}
}

- (NSData *)dataToReturn
{
	assert(_data_buf);
	NSData *d = [_data_buf autorelease];
	_data_buf = nil;
	return _error ? nil : d;
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[self stopWithError:error];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	assert(_data_buf);
	[_data_buf appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[self stopWithError:nil];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	self.lastStatusCode = [((NSHTTPURLResponse *) response) statusCode];
}

- (void) connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	//Accept invalid server certification
	[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
		 forAuthenticationChallenge:challenge];
}
@end
