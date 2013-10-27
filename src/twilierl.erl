
-module(twilierl).





-export([

    send/6

]).





send(AccountSid, AuthToken, SenderNumber, TargetNumber, Message, MediaUrl) when is_integer(AccountSid) ->

    send(integer_to_list(AccountSid), AuthToken, SenderNumber, TargetNumber, Message, MediaUrl);





send(AccountSid, AuthToken, SenderNumber, TargetNumber, Message, MediaUrl) when is_integer(SenderNumber) ->

    send(AccountSid, AuthToken, integer_to_list(SenderNumber), TargetNumber, Message, MediaUrl);





send(AccountSid, AuthToken, SenderNumber, TargetNumber, Message, MediaUrl) when is_integer(TargetNumber) ->

    send(AccountSid, AuthToken, SenderNumber, integer_to_list(TargetNumber), Message, MediaUrl);





% todo mediaurl support

send(AccountSid, AuthToken, SenderNumber, TargetNumber, Message, _MediaUrl) ->

    inets:start(),

    Target = "https://" ++ AccountSid ++ ":" ++ AuthToken ++ "@api.twilio.com/2010-04-01/Accounts/" ++ AccountSid ++ "/Messages.json",
    Args   = "From="  ++ http_uri:encode(SenderNumber) ++
             "&To="   ++ http_uri:encode(TargetNumber) ++
             "&Body=" ++ http_uri:encode(Message),

    httpc:request(post, {Target, [], "application/x-www-form-urlencoded", Args}, [], []).
