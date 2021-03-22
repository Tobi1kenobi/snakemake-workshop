SAMPLES = ["A", "B"]


rule all:
    input:
        "plots/quals.png"

include: "modules/map.smk"
include: "modules/call.smk"