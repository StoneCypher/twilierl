twilierl
========

Twilierl is a Twilio client for erlang.  Send SMSes from your REPL for a penny.  Woo.

So far it only does SMS sending.  No MMS, no media messages, no calls, etc, yet.

Usage
-----

Get your SID, Auth, and sender phone number from your control panel in your Twilio account.  (The free one will do, but it'll only SMS you.)

```erlang
1> SID = "41a3...".
"41a3..."

2> Auth = "4qn4t..."
"4qn4t..."

3> SendNumber = 6195550121.
6195550121

4> twilierl:send(SID, Auth, SendNumber, 4125550138, "This is a message sent from San Diego to Pittsburgh", undefined).
{ok,{{"HTTP/1.1",201,"CREATED"},
     [{"connection","close"},
      {"date","Sun, 27 Oct 2013 04:00:28 GMT"},
      {"content-length","675"},
      {"content-type","application/json"},
      {"x-powered-by","AT-5000"},
      {"x-shenanigans","none"}],
     "{\"sid\": \"SM069...\", \"date_created\": \"Sun, 27 Oct 2013 04:00:28 +0000\", \"date_updated\": \"Sun, 27 Oct 2013 04:00:28 +0000\", \"date_sent\": null, \"account_sid\": \"41a3...\", \"to\": \"+14125550138\", \"from\": \"+16195550121\", \"body\": \"aouheo\", \"status\": \"queued\", \"num_segments\": \"1\", \"num_media\": \"0\", \"direction\": \"outbound-api\", \"api_version\": \"2010-04-01\", \"price\": null, \"uri\": \"/2010-04-01/Accounts/41a3.../Messages/SM069....json\", \"subresource_uris\": {\"media\": \"/2010-04-01/Accounts/41a3.../Messages/SM069.../Media.json\"}}"}}
```

Pow.

Making it simpler
-----------------

Wrap your credentials up.

```erlang
5> MySend = fun(Num, Msg) -> twilierl:send(SID, Auth, SendNumber, Num, Msg, undefined) end.
#Fun<erl_eval.20.17052888>

6> MySend(4125550138, "I sent you a second message, lol").
{ok,{{"HTTP/1.1",201,"CREATED"},
     [{"connection","close"},
      {"date","Sun, 27 Oct 2013 04:00:28 GMT"},
      {"content-length","675"},
      {"content-type","application/json"},
      {"x-powered-by","AT-5000"},
      {"x-shenanigans","none"}],
     "{\"sid\": \"SM069...\", \"date_created\": \"Sun, 27 Oct 2013 04:00:28 +0000\", \"date_updated\": \"Sun, 27 Oct 2013 04:00:28 +0000\", \"date_sent\": null, \"account_sid\": \"41a3...\", \"to\": \"+14125550138\", \"from\": \"+16195550121\", \"body\": \"aouheo\", \"status\": \"queued\", \"num_segments\": \"1\", \"num_media\": \"0\", \"direction\": \"outbound-api\", \"api_version\": \"2010-04-01\", \"price\": null, \"uri\": \"/2010-04-01/Accounts/41a3.../Messages/SM069....json\", \"subresource_uris\": {\"media\": \"/2010-04-01/Accounts/41a3.../Messages/SM069.../Media.json\"}}"}}
```

Some notes
----------

You should have a [Twilio account](http://www.twilio.com/) set up for this.