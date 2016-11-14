(ns cljs-echo.cljs-echo 
  (:require [cljs.nodejs :as nodejs]
            [clojure.string :as string]))

(def process
  (nodejs/require "process"))

(def argc
  process.env.COG_ARGC)

(defn argv [n]
  (aget process.env (str "COG_ARGV_" n)))

(def args
  (map argv (range (int argc))))

(println (string/join " " args))
