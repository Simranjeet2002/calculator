defmodule Calculator do
    def start do
      spawn(fn -> loop(0) end)
    end
     defp loop(current_value) do
      new_value=receive do
         {:value, client_id} ->send(client_id,{:response,current_value})
         current_value
         {:add,value} ->  current_value + value
         {:sub,value} ->  current_value - value
         {:mul,value} ->  current_value * value
         {:div,value} ->  current_value / value #div

         invalid_request -> IO.puts("INVALID REQUEST -> #{inspect invalid_request}")
         current_value
      end

      loop(new_value)
     end
     def value(server_id) do
      send(server_id,{:value,self()})
      receive do
        {:response, value} -> value
      end
     end

     def add(pid,value) do
       send(pid,{:add,value})
       value(pid)
     end
     def sub(pid,value) do
      send(pid,{:sub,value})
      value(pid)
    end
    def mul(pid,value) do
      send(pid,{:mul,value})
      value(pid)
    end
    def div(pid,value) do
      send(pid,{:div,value})
      value(pid)
    end
end
