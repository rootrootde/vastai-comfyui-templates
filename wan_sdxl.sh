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
    "https://github.com/AIrjen/OneButtonPrompt" # 📁 AIrjen/OneButtonPrompt
    "https://github.com/Fannovel16/comfyui_controlnet_aux" # 📁 Fannovel16/comfyui_controlnet_aux
    "https://github.com/JPS-GER/ComfyUI_JPS-Nodes" # 📁 JPS-GER/ComfyUI_JPS-Nodes
    "https://github.com/Jonseed/ComfyUI-Detail-Daemon" # 📁 Jonseed/ComfyUI-Detail-Daemon
    "https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite" # 📁 Kosinkadink/ComfyUI-VideoHelperSuite
    "https://github.com/MoonGoblinDev/Civicomfy" # 📁 MoonGoblinDev/Civicomfy
    "https://github.com/SeargeDP/SeargeSDXL" # 📁 SeargeDP/SeargeSDXL
    "https://github.com/Smirnov75/ComfyUI-mxToolkit" # 📁 Smirnov75/ComfyUI-mxToolkit
    "https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes" # 📁 Suzie1/ComfyUI_Comfyroll_CustomNodes
    "https://github.com/alexopus/ComfyUI-Image-Saver" # 📁 alexopus/ComfyUI-Image-Saver
    "https://github.com/crystian/ComfyUI-Crystools" # 📁 crystian/ComfyUI-Crystools
    "https://github.com/cubiq/PuLID_ComfyUI" # 📁 cubiq/PuLID_ComfyUI
    "https://github.com/kijai/ComfyUI-Florence2" # 📁 kijai/ComfyUI-Florence2
    "https://github.com/kijai/ComfyUI-KJNodes" # 📁 kijai/ComfyUI-KJNodes
    "https://github.com/kijai/ComfyUI-WanVideoWrapper" # 📁 kijai/ComfyUI-WanVideoWrapper
    "https://github.com/lgldlk/ComfyUI-PC-ding-dong" # 📁 lgldlk/ComfyUI-PC-ding-dong
    "https://github.com/ltdrdata/ComfyUI-Impact-Pack" # 📁 ltdrdata/ComfyUI-Impact-Pack
    "https://github.com/ltdrdata/was-node-suite-comfyui" # 📁 ltdrdata/was-node-suite-comfyui
    "https://github.com/pythongosssss/ComfyUI-Custom-Scripts" # 📁 pythongosssss/ComfyUI-Custom-Scripts
    "https://github.com/rgthree/rgthree-comfy" # 📁 rgthree/rgthree-comfy
    "https://github.com/shiimizu/ComfyUI-TiledDiffusion" # 📁 shiimizu/ComfyUI-TiledDiffusion
    "https://github.com/sipherxyz/comfyui-art-venture" # 📁 sipherxyz/comfyui-art-venture
    "https://github.com/ssitu/ComfyUI_UltimateSDUpscale" # 📁 ssitu/ComfyUI_UltimateSDUpscale
    "https://github.com/yolain/ComfyUI-Easy-Use" # 📁 yolain/ComfyUI-Easy-Use
)

WORKFLOWS=(

)

CHECKPOINT_MODELS=(
    "https://civitai.com/api/download/models/1759168" # Juggernaut XL
    "https://huggingface.co/ByteDance/SDXL-Lightning" # 🤗 ByteDance/SDXL-Lightning
    "https://huggingface.co/crynux-ai/sdxl-turbo" # 🤗 crynux-ai/sdxl-turbo
    "https://huggingface.co/madebyollin/sdxl-vae-fp16-fix" # 🤗 madebyollin/sdxl-vae-fp16-fix
    "https://huggingface.co/stabilityai/sdxl-vae" # 🤗 stabilityai/sdxl-vae
    "https://civitai.com/api/download/models/1868891?type=Model&format=SafeTensor&size=full&fp=fp8" # Wan2.1_14B_FusionX
    "https://civitai.com/models/1651125?modelVersionId=1882322" # Wan2.1_14B_FusionX
)

UNET_MODELS=(

)

LORA_MODELS=(
    "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan21_CausVid_14B_T2V_lora_rank32.safetensors" # Wan21_CausVid_14B_T2V_lora_rank32.safetensors
)

VAE_MODELS=(
    "https://huggingface.co/madebyollin/sdxl-vae-fp16-fix/resolve/main/sdxl_vae.safetensors" # sdxl_vae.safetensors
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors" # wan_2.1_vae.safetensors
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
    "https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-canny-rank256.safetensors" # control-lora-canny-rank256.safetensors
    "https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-depth-rank256.safetensors" # control-lora-depth-rank256.safetensors
    "https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-recolor-rank256.safetensors" # control-lora-recolor-rank256.safetensors
    "https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-sketch-rank256.safetensors" # control-lora-sketch-rank256.safetensors
)

ANNOTATOR_MODELS=(
    "https://huggingface.co/lllyasviel/Annotators/resolve/main/ControlNetHED.pth" # ControlNetHED.pth
    "https://huggingface.co/lllyasviel/Annotators/resolve/main/res101.pth" # res101.pth
)

CLIP_VISION_MODELS=(
    "https://huggingface.co/stabilityai/control-lora/resolve/main/revision/clip_vision_g.safetensors" # clip_vision_g.safetensors
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors?download=true" # clip_vision_h.safetensors?download=true
)

TEXT_ENCODER_MODELS=(
    "https://huggingface.co/Comfy-Org/HiDream-I1_ComfyUI/resolve/main/split_files/text_encoders/clip_g_hidream.safetensors?download=true" # clip_g_hidream.safetensors?download=true
    "https://huggingface.co/Comfy-Org/HiDream-I1_ComfyUI/resolve/main/split_files/text_encoders/clip_l_hidream.safetensors?download=true" # clip_l_hidream.safetensors?download=true
    "https://huggingface.co/Comfy-Org/HiDream-I1_ComfyUI/resolve/main/split_files/text_encoders/t5xxl_fp8_e4m3fn_scaled.safetensors?download=true" # t5xxl_fp8_e4m3fn_scaled.safetensors?download=true
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp16.safetensors" # umt5_xxl_fp16.safetensors
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors?download=true" # umt5_xxl_fp8_e4m3fn_scaled.safetensors?download=true
)

DIFFUSION_MODELS=(
    "https://civitai.com/api/download/models/1882322?type=Model&format=SafeTensor&size=full&fp=fp8" # Wan2.1_14B_FusionX
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/diffusion_models/wan2.1_i2v_480p_14B_fp16.safetensors?download=true" # wan2.1_i2v_480p_14B_fp16.safetensors?download=true
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/diffusion_models/wan2.1_t2v_1.3B_fp16.safetensors?download=true" # wan2.1_t2v_1.3B_fp16.safetensors?download=true
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/diffusion_models/wan2.1_t2v_14B_fp16.safetensors" # wan2.1_t2v_14B_fp16.safetensors
)

CLIP_MODELS=(
    "https://huggingface.co/UmeAiRT/ComfyUI-Auto_installer/resolve/main/models/clip/clip_l.safetensors?download=true" # clip_l.safetensors?download=true
    "https://huggingface.co/UmeAiRT/ComfyUI-Auto_installer/resolve/main/models/clip/t5xxl_fp8_e4m3fn.safetensors?download=true" # t5xxl_fp8_e4m3fn.safetensors?download=true
)

STYLE_MODELS=(

)

PULID_MODELS=(

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