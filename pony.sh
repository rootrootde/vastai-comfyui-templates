#!/bin/bash

source /venv/main/bin/activate
COMFYUI_DIR=${WORKSPACE}/ComfyUI

# Configure parallel downloads (set to 1 to disable parallel downloading)
MAX_PARALLEL_DOWNLOADS=${MAX_PARALLEL_DOWNLOADS:-12}

# Packages are installed after nodes so we can fix them...

APT_PACKAGES=(

)

PIP_PACKAGES=(

)

NODES=(
    "https://github.com/FlyingFireCo/tiled_ksampler"
    "https://github.com/crystian/ComfyUI-Crystools" # 📁 crystian/ComfyUI-Crystools
    "https://github.com/ltdrdata/ComfyUI-Impact-Subpack"
    "https://github.com/MoonGoblinDev/Civicomfy" # 📁 MoonGoblinDev/Civicomfy
    "https://github.com/city96/ComfyUI-GGUF" # 📁 city96/ComfyUI-GGUF
    "https://github.com/kijai/ComfyUI-KJNodes" # 📁 kijai/ComfyUI-KJNodes
    "https://github.com/lgldlk/ComfyUI-PC-ding-dong" # 📁 lgldlk/ComfyUI-PC-ding-dong
    "https://github.com/ltdrdata/ComfyUI-Impact-Pack" # 📁 ltdrdata/ComfyUI-Impact-Pack
    "https://github.com/pythongosssss/ComfyUI-Custom-Scripts" # 📁 pythongosssss/ComfyUI-Custom-Scripts
    "https://github.com/rgthree/rgthree-comfy" # 📁 rgthree/rgthree-comfy
    "https://github.com/yolain/ComfyUI-Easy-Use" # 📁 yolain/ComfyUI-Easy-Use
    "https://github.com/excelwong/ComfyUI-PromptComposer"
)

WORKFLOWS=(

)

CHECKPOINT_MODELS=(
    "https://civitai.com/api/download/models/1888952?type=Model&format=SafeTensor&size=pruned&fp=fp16" # iLustMix
    "https://civitai.com/api/download/models/1838857?type=Model&format=SafeTensor&size=pruned&fp=fp16" # CyberRealistic Pony
    "https://civitai.com/api/download/models/1899516?type=Model&format=SafeTensor&size=pruned&fp=fp16" # CyberRealistic Pony Catalyst
    "https://civitai.com/api/download/models/1871475?type=Model&format=SafeTensor&size=pruned&fp=fp16" # CyberRealistic Pony Semi-Realistic
)

UNET_MODELS=(

)

LORA_MODELS=(
    "https://civitai.com/api/download/models/856243?type=Model&format=SafeTensor" # Adjusting clothes
    "https://civitai.com/api/download/models/520909?type=Model&format=SafeTensor" # Body Type Slider - Pony / Illustrious
    "https://civitai.com/api/download/models/534952?type=Model&format=SafeTensor" # Breast Size Slider - Pony / Illustrious
    "https://civitai.com/api/download/models/712947?type=Model&format=SafeTensor" # Detail Slider LoRA | PonyXL SDXL
    "https://civitai.com/api/download/models/593526?type=Model&format=SafeTensor" # Guided Breast Grab | LoRA
    "https://civitai.com/api/download/models/722613?type=Model&format=SafeTensor" # Mating press
    "https://civitai.com/api/download/models/517898?type=Model&format=SafeTensor" # Penis Size Slider - Pony/Illustrious
    "https://civitai.com/models/61099/fluxpony-perfect-full-round-breasts-and-slim-waist?modelVersionId=692326" # [Flux/Pony] Perfect Full Round Breasts & Slim Waist
)

VAE_MODELS=(

)

ESRGAN_MODELS=(

)

UPSCALE_MODELS=(
    "https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/1x-ITF-SkinDiffDetail-Lite-v1.pth" # 1x-ITF-SkinDiffDetail-Lite-v1.pth
    "https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x-UltraSharp.pth" # 4x-UltraSharp.pth
    "https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x_NMKD-Siax_200k.pth" # 4x_NMKD-Siax_200k.pth
    "https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x_Nickelback_70000G.pth" # 4x_Nickelback_70000G.pth
    "https://huggingface.co/spaces/Marne/Real-ESRGAN/blob/main/RealESRGAN_x4plus.pth" # 🤗 RealESRGAN_x4plus.pth
    "https://huggingface.co/spaces/Marne/Real-ESRGAN/blob/main/RealESRGAN_x4plus_anime_6B.pth" # 🤗 RealESRGAN_x4plus_anime_6B.pth
)

CONTROLNET_MODELS=(

)

ANNOTATOR_MODELS=(

)

CLIP_VISION_MODELS=(

)

TEXT_ENCODER_MODELS=(

)

DIFFUSION_MODELS=(

)

CLIP_MODELS=(

)

STYLE_MODELS=(

)

PULID_MODELS=(

)

ULTRALYTICS_MODELS=(
    "https://huggingface.co/jags/yolov8_model_segmentation-set/resolve/main/face_yolov8m-seg_60.pt" # face_yolov8m-seg_60.pt
    "https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt?download=true" # face_yolov8m.pt?download=true
    "https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8n.pt?download=true" # face_yolov8n.pt?download=true
    "https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8n_v2.pt?download=true" # face_yolov8n_v2.pt?download=true
    "https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8s.pt?download=true" # face_yolov8s.pt?download=true
    "https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov9c.pt?download=true" # face_yolov9c.pt?download=true
    "https://huggingface.co/Bingsu/adetailer/resolve/main/hand_yolov8n.pt?download=true" # hand_yolov8n.pt?download=true
    "https://huggingface.co/Bingsu/adetailer/resolve/main/hand_yolov8s.pt?download=true" # hand_yolov8s.pt?download=true
    "https://huggingface.co/Bingsu/adetailer/resolve/main/hand_yolov9c.pt?download=true" # hand_yolov9c.pt?download=true
)

SAM_MODELS=(
    "https://huggingface.co/datasets/Gourieff/ReActor/resolve/main/models/sams/sam_vit_b_01ec64.pth" # sam_vit_b_01ec64.pth
    "https://huggingface.co/spaces/facebook/ov-seg/resolve/main/sam_vit_l_0b3195.pth" # sam_vit_l_0b3195.pth
)


function provisioning_start() {
    provisioning_print_header
    provisioning_get_apt_packages
    provisioning_get_nodes
    provisioning_get_pip_packages
    provisioning_get_workflows
    provisioning_get_files "${COMFYUI_DIR}/models/checkpoints" "${CHECKPOINT_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/unet" "${UNET_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/loras" "${LORA_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/controlnet" "${CONTROLNET_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/vae" "${VAE_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/esrgan" "${ESRGAN_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/upscale_models" "${UPSCALE_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/annotators" "${ANNOTATOR_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/clip_vision" "${CLIP_VISION_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/text_encoders" "${TEXT_ENCODER_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/diffusion_models" "${DIFFUSION_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/clip" "${CLIP_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/style_models" "${STYLE_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/pulid" "${PULID_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/ultralytics/bbox" "${ULTRALYTICS_MODELS[@]}"
    provisioning_get_files "${COMFYUI_DIR}/models/sams" "${SAM_MODELS[@]}"
    provisioning_print_end
}

function provisioning_get_apt_packages() {
    if [[ -n $APT_PACKAGES ]]; then
            sudo $APT_INSTALL ${APT_PACKAGES[@]}
    fi
}

function provisioning_get_pip_packages() {
    if [[ -n $PIP_PACKAGES ]]; then
            pip install --no-cache-dir ${PIP_PACKAGES[@]}
    fi
}

function provisioning_get_workflows() {
    if [[ ${#WORKFLOWS[@]} -eq 0 ]]; then
        return
    fi
    
    mkdir -p "${COMFYUI_DIR}/user/default/workflows"
    printf "Downloading %s workflow(s)...\\n" "${#WORKFLOWS[@]}"
    
    for url in "${WORKFLOWS[@]}"; do
        printf "Downloading workflow: %s\\n" "${url}"
        provisioning_download "${url}" "${COMFYUI_DIR}/user/default/workflows"
        printf "\\n"
    done
}

function provisioning_get_nodes() {
    for repo in "${NODES[@]}"; do
        dir="${repo##*/}"
        path="${COMFYUI_DIR}/custom_nodes/${dir}"
        requirements="${path}/requirements.txt"
        if [[ -d $path ]]; then
            if [[ ${AUTO_UPDATE,,} != "false" ]]; then
                printf "Updating node: %s...\\n" "${repo}"
                ( cd "$path" && git pull )
                if [[ -e $requirements ]]; then
                   pip install --no-cache-dir -r "$requirements"
                fi
            fi
        else
            printf "Downloading node: %s...\\n" "${repo}"
            git clone "${repo}" "${path}" --recursive
            if [[ -e $requirements ]]; then
                pip install --no-cache-dir -r "${requirements}"
            fi
        fi
    done
}

function provisioning_get_files() {
    if [[ -z $2 ]]; then return 1; fi
    
    dir="$1"
    mkdir -p "$dir"
    shift
    arr=("$@")
    printf "Downloading %s model(s) to %s...\\n" "${#arr[@]}" "$dir"
    
    if [[ $MAX_PARALLEL_DOWNLOADS -le 1 ]]; then
        # Sequential downloads (original behavior)
        for url in "${arr[@]}"; do
            printf "Downloading: %s\\n" "${url}"
            provisioning_download "${url}" "${dir}"
            printf "\\n"
        done
    else
        # Parallel downloads
        local pids=()
        local active_downloads=0
        local download_count=0
        local total_downloads=${#arr[@]}
        
        for url in "${arr[@]}"; do
            # Wait if we've reached the max parallel downloads
            while [[ $active_downloads -ge $MAX_PARALLEL_DOWNLOADS ]]; do
                # Check for completed downloads
                for i in "${!pids[@]}"; do
                    if ! kill -0 "${pids[i]}" 2>/dev/null; then
                        wait "${pids[i]}"
                        unset pids[i]
                        ((active_downloads--))
                    fi
                done
                # Brief sleep to avoid busy waiting
                sleep 0.1
            done
            
            # Start download in background
            ((download_count++))
            printf "[%d/%d] Starting download: %s\\n" "$download_count" "$total_downloads" "${url}"
            (
                provisioning_download "${url}" "${dir}"
                printf "[COMPLETED] %s\\n" "${url##*/}"
            ) &
            pids+=($!)
            ((active_downloads++))
        done
        
        # Wait for all remaining downloads to complete
        printf "Waiting for %d remaining downloads to complete...\\n" "$active_downloads"
        for pid in "${pids[@]}"; do
            wait "$pid"
        done
        printf "All downloads completed for %s\\n" "$dir"
        printf "\\n"
    fi
}

function provisioning_print_header() {
    printf "\\n##############################################\\n#                                            #\\n#          Provisioning container            #\\n#                                            #\\n#         This will take some time           #\\n#                                            #\\n# Your container will be ready on completion #\\n#                                            #\\n##############################################\\n\\n"
}

function provisioning_print_end() {
    printf "\\nProvisioning complete:  Application will start now\\n\\n"
}

function provisioning_has_valid_hf_token() {
    [[ -n "$HF_TOKEN" ]] || return 1
    url="https://huggingface.co/api/whoami-v2"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \\
        -H "Authorization: Bearer $HF_TOKEN" \\
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

function provisioning_has_valid_civitai_token() {
    [[ -n "$CIVITAI_TOKEN" ]] || return 1
    url="https://civitai.com/api/v1/models?hidden=1&limit=1"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \\
        -H "Authorization: Bearer $CIVITAI_TOKEN" \\
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

# Download from $1 URL to $2 file path
function provisioning_download() {
    local url="$1"
    local dest_dir="$2"
    
    if [[ -n $HF_TOKEN && $url =~ ^https://([a-zA-Z0-9_-]+\\.)?huggingface\\.co(/|$|\\?) ]]; then
        wget --header="Authorization: Bearer $HF_TOKEN" -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$dest_dir" "$url"
    elif [[ -n $CIVITAI_TOKEN && $url =~ ^https://([a-zA-Z0-9_-]+\\.)?civitai\\.com(/|$|\\?) ]]; then
        # CivitAI uses a redirect-based download system with Bearer token
        # First, get the redirect URL with authentication
        local redirect_url=$(curl -s -L -w "%{url_effective}" -o /dev/null \\
            -H "Authorization: Bearer $CIVITAI_TOKEN" \\
            -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \\
            "$url")
        
        # If we got a redirect, download from there
        if [[ -n $redirect_url && $redirect_url != $url ]]; then
            wget -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$dest_dir" "$redirect_url"
        else
            # Fallback to direct download with Bearer token
            wget --header="Authorization: Bearer $CIVITAI_TOKEN" \\
                 --header="User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \\
                 -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$dest_dir" "$url"
        fi
    else
        wget -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$dest_dir" "$url"
    fi
}

# Allow user to disable provisioning if they started with a script they didn't want
if [[ ! -f /.noprovisioning ]]; then
    provisioning_start
fi