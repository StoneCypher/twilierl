
-module(twilierl).





-export([

    send/6

]).





% if the accountsid is presented as a number, turn it into a list

send(AccountSid, AuthToken, SenderNumber, TargetNumber, Message, MediaUrl) when is_integer(AccountSid) ->

    send(integer_to_list(AccountSid), AuthToken, SenderNumber, TargetNumber, Message, MediaUrl);





% if the sender number is presented as a number, turn it into a list

send(AccountSid, AuthToken, SenderNumber, TargetNumber, Message, MediaUrl) when is_integer(SenderNumber) ->

    send(AccountSid, AuthToken, integer_to_list(SenderNumber), TargetNumber, Message, MediaUrl);





% if the target number is presented as a number, turn it into a list

send(AccountSid, AuthToken, SenderNumber, TargetNumber, Message, MediaUrl) when is_integer(TargetNumber) ->

    send(AccountSid, AuthToken, SenderNumber, integer_to_list(TargetNumber), Message, MediaUrl);





%%%%%%%%%
%%
%%  @doc Sends an SMS over the Twilio network.  Fairly hackish but it works.  Does not length limit.  
%%
%%  MediaUrl param is because media is something we intend to support, but have not yet; that's for later.  For clarity, in the current
%%  source code, the MediaUrl is *not* supported.
%%
%%  ```1> SID = "41a3...".
%%  "41a3..."
%%  
%%  2> Auth = "4qn4t..."
%%  "4qn4t..."
%%  
%%  3> SendNumber = 6195550121.
%%  6195550121
%%  
%%  4> twilierl:send(SID, Auth, SendNumber, 4125550138, "This is a message sent from San Diego to Pittsburgh", undefined).
%%  {ok,{{"HTTP/1.1",201,"CREATED"},
%%       [{"connection","close"},
%%        {"date","Sun, 27 Oct 2013 04:00:28 GMT"},
%%        {"content-length","675"},
%%        {"content-type","application/json"},
%%        {"x-powered-by","AT-5000"},
%%        {"x-shenanigans","none"}],
%%       "{\"sid\": \"SM069...\", \"date_created\": \"Sun, 27 Oct 2013 04:00:28 +0000\", \"date_updated\": \"Sun, 27 Oct 2013 04:00:28 +0000\", \"date_sent\": null, \"account_sid\": \"41a3...\", \"to\": \"+14125550138\", \"from\": \"+16195550121\", \"body\": \"aouheo\", \"status\": \"queued\", \"num_segments\": \"1\", \"num_media\": \"0\", \"direction\": \"outbound-api\", \"api_version\": \"2010-04-01\", \"price\": null, \"uri\": \"/2010-04-01/Accounts/41a3.../Messages/SM069....json\", \"subresource_uris\": {\"media\": \"/2010-04-01/Accounts/41a3.../Messages/SM069.../Media.json\"}}"}}'''
%%
%%  @todo mediaurl support

-spec send(AccountSid::list(), AuthToken::list(), SenderNumber::list(), TargetNumber::list(), Message::list(), MediaUrl::list()) -> json().

send(AccountSid, AuthToken, SenderNumber, TargetNumber, Message, _MediaUrl) ->

    % todo whargarbl lol this is ugly
    inets:start(),
    ssl:start(),

    Target = "https://" ++ AccountSid ++ ":" ++ AuthToken ++ "@api.twilio.com/2010-04-01/Accounts/" ++ AccountSid ++ "/Messages.json",
    Args   = "From="  ++ http_uri:encode(SenderNumber) ++
             "&To="   ++ http_uri:encode(TargetNumber) ++
             "&Body=" ++ http_uri:encode(Message),

    httpc:request(post, {Target, [], "application/x-www-form-urlencoded", Args}, [], []).
