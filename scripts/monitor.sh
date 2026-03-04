#!/bin/bash
# OpenClaw 系统监控脚本
# 用法: ./monitor.sh [--cpu|--mem|--disk]

THRESHOLD_CPU=80
THRESHOLD_MEM=85
THRESHOLD_DISK=90

check_cpu() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    CPU_INT=${CPU_USAGE%.*}
    
    echo "CPU 使用率: ${CPU_INT}%"
    
    if [ "$CPU_INT" -gt "$THRESHOLD_CPU" ]; then
        echo "⚠️ CPU 使用率超过 ${THRESHOLD_CPU}%！"
        return 1
    fi
    return 0
}

check_mem() {
    MEM_USAGE=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')
    
    echo "内存使用率: ${MEM_USAGE}%"
    
    if [ "$MEM_USAGE" -gt "$THRESHOLD_MEM" ]; then
        echo "⚠️ 内存使用率超过 ${THRESHOLD_MEM}%！"
        return 1
    fi
    return 0
}

check_disk() {
    DISK_USAGE=$(df -h / | tail -1 | awk '{print $5}' | sed 's/%//')
    
    echo "磁盘使用率: ${DISK_USAGE}%"
    
    if [ "$DISK_USAGE" -gt "$THRESHOLD_DISK" ]; then
        echo "⚠️ 磁盘使用率超过 ${THRESHOLD_DISK}%！"
        return 1
    fi
    return 0
}

# 根据参数选择检查项
case "${1:-all}" in
    --cpu)
        check_cpu
        ;;
    --mem)
        check_mem
        ;;
    --disk)
        check_disk
        ;;
    *)
        echo "=== 系统状态检查 ==="
        check_cpu
        check_mem
        check_disk
        ;;
esac
