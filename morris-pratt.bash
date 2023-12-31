#!/bin/bash


function prefix_function {
    local pattern=$1
    local m=${#pattern}
    local pi=(0)

    for ((i=1; i<m; i++)); do
        j=${pi[i-1]}

        while ((j>0 && pattern[i]!=pattern[j])); do
            j=${pi[j-1]}
        done

        if ((pattern[i]==pattern[j])); then
            pi[i]=$((j+1))
        else
            pi[i]=0
        fi
    done

    echo "${pi[@]}"
}


function morris_pratt {
    local text=$1
    local pattern=$2
    local n=${#text}
    local m=${#pattern}
    local pi=($(prefix_function $pattern))
    local j=0

    for ((i=0; i<n; i++)); do
        while ((j>0 && text[i]!=pattern[j])); do
            j=${pi[j-1]}
        done

        if ((text[i]==pattern[j])); then
            ((j++))
        fi

        if ((j==m)); then
            echo "Подстрока найдена в позиции $((i-m+1))"
            j=${pi[j-1]}
        fi
    done
}


text=$1
pattern=$2
morris_pratt "$text" "$pattern"
