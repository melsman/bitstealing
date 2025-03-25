structure Stat = struct

fun sq x : real = x * x

fun average (xs:real list) : real =
    case xs of
        nil => 0.0
      | _ => List.foldl (op +) 0.0 xs / (real(length xs))

fun average_sd (xs:real list) : {avg:real,sd:real} =
    let val avg = average xs
    in case xs of
           nil => {avg=0.0,sd=0.0}
         | [x] => {avg=avg,sd=0.0}
         | _ => {avg=avg,
                 sd=Math.sqrt (List.foldl (op +) 0.0 (List.map (fn x => sq(x-avg)) xs) / (real(length xs - 1)))}
    end

fun average_rsd (xs:real list) : {avg:real,rsd:real} =
    let val {avg,sd} = average_sd xs
    in if Real.==(0.0,avg) then {avg=avg,rsd=0.0}
       else {avg=avg,rsd=100.0*sd/avg}
    end

type t = {avg:real,rsd:real}

fun improvement (s:string) (old:t) (new:t) : unit =
    print (s ^ ": " ^ Real.toString (100.0 * (#avg old / #avg new - 1.0)) ^ "\n")

end

infix |>
fun a |> f = f a;

val mlkit_time_old = [395.74,391.98,396.04,399.11,399.00] |> Stat.average_rsd;
val mlkit_time_new = [362.58,366.73,365.96,364.50,365.43] |> Stat.average_rsd;
val mlkit_rss_old = [734941184,734593024,734699520,735051776,734519296] |> map real |> Stat.average_rsd;
val mlkit_rss_new = [570904576,571056128,570978304,571023360,570970112] |> map real |> Stat.average_rsd;
val mlton_time_old = [1697.99,1699.10,1662.16,1637.81,1665.08] |> Stat.average_rsd;
val mlton_time_new = [1572.79,1605.27,1558.58,1556.96,1517.82] |> Stat.average_rsd;
val mlton_rss_old = [4856647680,4852195328,4835713024,4859981824,4852813824] |> map real |> Stat.average_rsd;
val mlton_rss_new = [4483158016,4483280896,4482895872,4482789376,4482818048] |> map real |> Stat.average_rsd;

val () = Stat.improvement "MLKit Time" mlkit_time_old mlkit_time_new;
val () = Stat.improvement "MLKit RSS" mlkit_rss_old mlkit_rss_new;
val () = Stat.improvement "MLton Time" mlton_time_old mlton_time_new;
val () = Stat.improvement "MLton RSS" mlton_rss_old mlton_rss_new;
