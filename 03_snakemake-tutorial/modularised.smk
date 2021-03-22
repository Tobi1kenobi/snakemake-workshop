SAMPLES = ["A", "B"]


rule all:
    input:
        "plots/quals.svg"

include: "modules/map.smk"
include: "modules/call.smk"