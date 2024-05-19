# See ABOUT
# https://huggingface.co/spaces/HuggingFaceH4/open_llm_leaderboard 

# !/bin/bash
git clone https://github.com/EleutherAI/lm-evaluation-harness
cd lm-evaluation-harness
pip install -e .

model_args="pretrained=unsloth/llama-3-8b-Instruct-bnb-4bit,use_accelerate=True"
out_path="./output"
bsz=8
tasks=("arc_challenge" "hellaswag" "truthfulqa_mc" "winogrande" "gsm8k")
num_fewshot=(25 10 0 5 5)

# MMLU
output_file="$model_args/$out_path/mmlu.txt"
python main.py \
    --model=hf-causal-experimental \
    --model_args $model_args \
    --tasks=hendrycksTest-abstract_algebra,hendrycksTest-anatomy,hendrycksTest-astronomy,hendrycksTest-business_ethics,hendrycksTest-clinical_knowledge,hendrycksTest-college_biology,hendrycksTest-college_chemistry,hendrycksTest-college_computer_science,hendrycksTest-college_mathematics,hendrycksTest-college_medicine,hendrycksTest-college_physics,hendrycksTest-computer_security,hendrycksTest-conceptual_physics,hendrycksTest-econometrics,hendrycksTest-electrical_engineering,hendrycksTest-elementary_mathematics,hendrycksTest-formal_logic,hendrycksTest-global_facts,hendrycksTest-high_school_biology,hendrycksTest-high_school_chemistry,hendrycksTest-high_school_computer_science,hendrycksTest-high_school_european_history,hendrycksTest-high_school_geography,hendrycksTest-high_school_government_and_politics,hendrycksTest-high_school_macroeconomics,hendrycksTest-high_school_mathematics,hendrycksTest-high_school_microeconomics,hendrycksTest-high_school_physics,hendrycksTest-high_school_psychology,hendrycksTest-high_school_statistics,hendrycksTest-high_school_us_history,hendrycksTest-high_school_world_history,hendrycksTest-human_aging,hendrycksTest-human_sexuality,hendrycksTest-international_law,hendrycksTest-jurisprudence,hendrycksTest-logical_fallacies,hendrycksTest-machine_learning,hendrycksTest-management,hendrycksTest-marketing,hendrycksTest-medical_genetics,hendrycksTest-miscellaneous,hendrycksTest-moral_disputes,hendrycksTest-moral_scenarios,hendrycksTest-nutrition,hendrycksTest-philosophy,hendrycksTest-prehistory,hendrycksTest-professional_accounting,hendrycksTest-professional_law,hendrycksTest-professional_medicine,hendrycksTest-professional_psychology,hendrycksTest-public_relations,hendrycksTest-security_studies,hendrycksTest-sociology,hendrycksTest-us_foreign_policy,hendrycksTest-virology,hendrycksTest-world_religions \
    --num_fewshot 5 \
    --batch_size $bsz \
    --output_path $output_file

# Iterate over tasks and num_fewshot values
for ((i=0; i<${#tasks[@]}; i++)); do
    task=${tasks[i]}
    output_file="$model_args/$out_path/$task.txt"
    python main.py \
        --model=hf-causal-experimental \
        --model_args $model_args \
        --tasks $task \
        --num_fewshot ${num_fewshot[i]} \
        --batch_size $bsz \
        --output_path $output_file
done
