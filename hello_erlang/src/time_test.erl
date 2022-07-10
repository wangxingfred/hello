%%%-------------------------------------------------------------------
%%% @author fred
%%% @copyright (C) 2022, localhost
%%% @doc
%%%     TODO 模块描述
%%% @end
%%% Created : 11. 6月 2022 17:52
%%%-------------------------------------------------------------------
-module(time_test).

-copyright({jzyx, 'www.jzyx.com'}).
-author({fred, 'wangxingfred@gmail.com'}).
-vsn(1).

%%%===============================INCLUDE================================

%%%================================DEFINE================================
%% 不需要给其它模块用的宏定义可以写到这里，避免放到头文件中修改后增加编译时间

%%%================================EXPORT================================
-compile([export_all, nowarn_export_all]).

info() ->
    %% TODO delete
    io:format("~n------------------~p:~p-----------------~n", [?MODULE, ?LINE]),
    io:format("os_monotonic_time_source = ~p~n", [erlang:system_info(os_monotonic_time_source)]),
    io:format("os_system_time_source = ~p~n", [erlang:system_info(os_system_time_source)]),
    io:format("time_offset = ~p~n", [erlang:system_info(time_offset)]),
    io:format("time_warp_mode = ~p~n", [erlang:system_info(time_warp_mode)]),
    io:format("time_correction = ~p~n", [erlang:system_info(time_correction)]),

    %% The Erlang monotonic time in native time unit at the time when current Erlang runtime system instance started.
    io:format("start_time = ~p~n", [erlang:system_info(start_time)]),
    %% The last Erlang monotonic time in native time unit that can be represented internally in the current Erlang runtime system instance.
    %% The time between the start time and the end time is at least a quarter of a millennium.
    io:format("end_time = ~p~n", [erlang:system_info(end_time)]),
    io:format("-----------------------------------------------------------------~n"),
    ok.

monotonic() ->
    %% Returns the current Erlang monotonic time in native time unit.
    %% This is a monotonically increasing time since some unspecified point in time.
    MonotonicNative = erlang:monotonic_time(),

    %% Returns the current Erlang monotonic time converted into the Unit passed as argument.
    %% Same as calling erlang:convert_time_unit( erlang:monotonic_time(), native, Unit),
    %% however optimized for commonly used Units.
    Unit = millisecond,
    MonotonicMillisecond1 = erlang:monotonic_time(Unit),

    MonotonicMillisecond2 = erlang:convert_time_unit(MonotonicNative, native, Unit),

    %% TODO delete
    io:format("~n------------------~p:~p-----------------~n", [?MODULE, ?LINE]),
    io:format("MonotonicNative = ~p~n", [MonotonicNative]),
    io:format("MonotonicMillisecond1 = ~p~n", [MonotonicMillisecond1]),
    io:format("MonotonicMillisecond2 = ~p~n", [MonotonicMillisecond2]),
    io:format("-----------------------------------------------------------------~n"),
    ok.

system() ->
    %% Returns current Erlang system time in native time unit.
    %% Calling erlang:system_time() is equivalent to erlang:monotonic_time() + erlang:time_offset().
    ErlSystemNative1 = erlang:system_time(),

    TimeOffset = erlang:time_offset(),
    ErlMonotonicNative2 = erlang:monotonic_time(),
    ErlSystemNative2 = ErlMonotonicNative2 + TimeOffset,

    OsSystemNative3 = os:system_time(),

    %% Returns current Erlang system time converted into the Unit passed as argument.
    %% Calling erlang:system_time(Unit) is equivalent to erlang:convert_time_unit(erlang:system_time(), native, Unit).
    Unit = second,
    ErlSystemSecond4 = erlang:system_time(Unit),
    ErlSystemSecond1 = erlang:convert_time_unit(ErlSystemNative1, native, Unit),

    OsSystemSecond3 = erlang:convert_time_unit(OsSystemNative3, native, Unit),

    %% TODO delete
    io:format("~n------------------~p:~p-----------------~n", [?MODULE, ?LINE]),
    io:format("ErlSystemNative1 = ~p~n", [ErlSystemNative1]),
    io:format("ErlSystemSecond1 = ~p~n", [ErlSystemSecond1]),

    io:format("TimeOffset = ~p~n", [TimeOffset]),
    io:format("ErlMonotonicNative2 = ~p~n", [ErlMonotonicNative2]),
    io:format("ErlSystemNative2 = ~p~n", [ErlSystemNative2]),

    io:format("OsSystemNative3 = ~p~n", [OsSystemNative3]),
    io:format("OsSystemSecond3 = ~p~n", [OsSystemSecond3]),
    io:format("ErlSystemSecond4 = ~p~n", [ErlSystemSecond4]),
    io:format("-----------------------------------------------------------------~n"),

    ok.

stamp() ->
    {MegaSecs1, Secs1, MicroSecs1} = erlang:timestamp(),

    %% The erlang:timestamp() BIF is equivalent to:
    ErlangSystemTime = erlang:system_time(microsecond),
    MegaSecs2 = ErlangSystemTime div 1000_000_000_000,
    Secs2 = ErlangSystemTime div 1000_000 - MegaSecs2*1000_000,
    MicroSecs2 = ErlangSystemTime rem 1000_000,
%%    {MegaSecs2, Secs2, MicroSecs2},
    % It, however, uses a native implementation that does not build garbage on the heap and
    % with slightly better performance.

    %% TODO delete
    io:format("~n------------------~p:~p-----------------~n", [?MODULE, ?LINE]),
    io:format("{MegaSecs1, Secs1, MicroSecs1} = ~p~n", [{MegaSecs1, Secs1, MicroSecs1}]),
    io:format("{MegaSecs2, Secs2, MicroSecs2} = ~p~n", [{MegaSecs2, Secs2, MicroSecs2}]),
    io:format("-----------------------------------------------------------------~n"),

    ok.