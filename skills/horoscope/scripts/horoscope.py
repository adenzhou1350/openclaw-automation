#!/usr/bin/env python3
"""
星座运势获取脚本
Usage: python horoscope.py --zodiac Aries
"""

import argparse
import json
import random
from datetime import datetime

# 星座映射
ZODIAC_MAP = {
    'aries': ('白羊座', '♈'),
    'taurus': ('金牛座', '♉'),
    'gemini': ('双子座', '♊'),
    'cancer': ('巨蟹座', '♋'),
    'leo': ('狮子座', '♌'),
    'virgo': ('处女座', '♍'),
    'libra': ('天秤座', '♎'),
    'scorpio': ('天蝎座', '♏'),
    'sagittarius': ('射手座', '♐'),
    'capricorn': ('摩羯座', '♑'),
    'aquarius': ('水瓶座', '♒'),
    'pisces': ('双鱼座', '♓'),
}

# 运势描述库
CAREER_TIPS = [
    "今日工作运势不错，适合开展新项目",
    "可能会遇到一些挑战，保持积极心态",
    "适合团队协作，多与同事沟通",
    "工作效率较高，可以处理遗留任务",
    "有晋升或加薪的机会，值得期待",
]

LOVE_TIPS = [
    "感情运势平稳，单身者可多参加社交活动",
    "与伴侣关系融洽，适合约会",
    "可能有新恋情出现，注意把握机会",
    "需要多关心另一半，增进感情",
    "适合表白或求婚，成功率较高",
]

HEALTH_TIPS = [
    "注意休息，避免过度劳累",
    "健康状况良好，保持现有作息",
    "适合运动锻炼，提升身体素质",
    "注意饮食卫生，避免肠胃不适",
    "精神状态佳，免疫力较强",
]

FINANCE_TIPS = [
    "财务状况良好，可适当理财",
    "有意外收入的可能，保持关注",
    "注意开销，避免冲动消费",
    "适合投资，但需谨慎决策",
    "财务运势上升，财源广进",
]

LUCKY_COLORS = ['红色', '蓝色', '绿色', '黄色', '紫色', '白色', '黑色', '橙色']
LUCKY_NUMBERS = list(range(1, 13))


def generate_horoscope(zodiac: str) -> dict:
    """生成星座运势"""
    zodiac = zodiac.lower()
    if zodiac not in ZODIAC_MAP:
        raise ValueError(f"未知星座: {zodiac}")

    zodiac_name, zodiac_emoji = ZODIAC_MAP[zodiac]

    # 使用日期作为随机种子，保证同一天同一星座结果一致
    today = datetime.now().strftime('%Y%m%d')
    seed = int(today) + hash(zodiac) % 1000
    random.seed(seed)

    return {
        'zodiac': zodiac,
        'zodiac_name': zodiac_name,
        'zodiac_emoji': zodiac_emoji,
        'date': datetime.now().strftime('%m月%d日'),
        'career': random.choice(CAREER_TIPS),
        'career_stars': random.randint(2, 5),
        'love': random.choice(LOVE_TIPS),
        'love_stars': random.randint(2, 5),
        'health': random.choice(HEALTH_TIPS),
        'health_stars': random.randint(2, 5),
        'finance': random.choice(FINANCE_TIPS),
        'finance_stars': random.randint(2, 5),
        'lucky_color': random.choice(LUCKY_COLORS),
        'lucky_number': random.choice(LUCKY_NUMBERS),
    }


def format_horoscope(horoscope: dict) -> str:
    """格式化运势输出"""
    def stars(n):
        return '⭐' * n + '☆' * (5 - n)

    return f"""{horoscope['zodiac_emoji']} 今日星座运势 - {horoscope['zodiac_name']} ({horoscope['date']})

💼 事业: {stars(horoscope['career_stars'])} {horoscope['career']}
💕 爱情: {stars(horoscope['love_stars'])} {horoscope['love']}
💪 健康: {stars(horoscope['health_stars'])} {horoscope['health']}
💰 财运: {stars(horoscope['finance_stars'])} {horoscope['finance']}

✨ 幸运色: {horoscope['lucky_color']}
✨ 幸运数字: {horoscope['lucky_number']}"""


def main():
    parser = argparse.ArgumentParser(description='星座运势查询')
    parser.add_argument('--zodiac', required=True, help='星座名称 (英文)')
    parser.add_argument('--json', action='store_true', help='输出 JSON 格式')
    args = parser.parse_args()

    horoscope = generate_horoscope(args.zodiac)

    if args.json:
        print(json.dumps(horoscope, ensure_ascii=False, indent=2))
    else:
        print(format_horoscope(horoscope))


if __name__ == '__main__':
    main()
