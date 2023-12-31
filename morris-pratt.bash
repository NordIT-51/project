#!/bin/bash

# Функция для построения префикс-функции
function prefix_function() {
    local pattern=$1
    local m=${#pattern}
    local pi=()

    pi[0]=0
    k=0

    for q in $(seq 1 $((m-1))); do
        while [[ $k -gt 0 && ${pattern:$k:1} != ${pattern:$q:1} ]]; do
            k=${pi[$k-1]}
        done

        if [[ ${pattern:$k:1} == ${pattern:$q:1} ]]; then
            ((k++))
        fi

        pi[$q]=$k
    done

    echo "${pi[@]}"
}

# Функция для поиска подстроки
function kmp_search() {
    local text=$1
    local pattern=$2
    local n=${#text}
    local m=${#pattern}
    local pi=($(prefix_function $pattern))
    local q=0

    for i in $(seq 0 $((n-1))); do
        while [[ $q -gt 0 && ${pattern:$q:1} != ${text:$i:1} ]]; do
            q=${pi[$q-1]}
        done

        if [[ ${pattern:$q:1} == ${text:$i:1} ]]; then
            ((q++))
        fi

        if [[ $q -eq $m ]]; then
            echo "Подстрока найдена в позиции $((i-m+1))"
            q=${pi[$q-1]}
        fi
    done
}

# Пример использования
text=$1
pattern=$2
echo "Строка: $text"
echo "Искомая последовательность: $pattern"
kmp_search $text $pattern
