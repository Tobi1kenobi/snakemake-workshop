SAMPLES = ["A", "B"]


rule all:
    input:
        "plots/quals.png"

# Here I have simply moved the moles into other snakefiles to tidy up the code
# and potentially re-use in other pipelines
include: "modules/map.smk"
include: "modules/call.smk"