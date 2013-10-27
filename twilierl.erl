
-module(twilierl).





-export([

    send/7

]).





send(AccountSid, User, Pass, SenderNumber, TargetNumber, Message, MediaUrl) when is_integer(AccountSid) ->

    send(integer_to_list(AccountSid), User, Pass, SenderNumber, TargetNumber, Message, MediaUrl);





send(AccountSid, User, Pass, SenderNumber, TargetNumber, Message, MediaUrl) when is_integer(SenderNumber) ->

    send(AccountSid, User, Pass, integer_to_list(SenderNumber), TargetNumber, Message, MediaUrl);





send(AccountSid, User, Pass, SenderNumber, TargetNumber, Message, MediaUrl) when is_integer(TargetNumber) ->

    send(AccountSid, User, Pass, SenderNumber, integer_to_list(TargetNumber), Message, MediaUrl);





send(AccountSid, User, Pass, SenderNumber, TargetNumber, Message, MediaUrl) ->

    inets:start(),

    Target = "https://api.twilio.com/2010-04-01/Accounts/" ++ AccountSid ++ "/Messages",

    Target.

%    case httpc:request(post, Target) of
%        
%        {ok,{{_,RCode,_},_,Ret}} -> {RCode, Ret};
%        Other                    -> {error, Other}
%
%    end.
