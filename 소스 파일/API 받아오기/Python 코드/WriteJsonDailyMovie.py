'''
https://www.kobis.or.kr/
'''
from datetime import datetime, timedelta
import requests
import json
import os
import json


def generate_date_range(start_date, end_date):
    date_format = "%Y%m%d"  # 날짜 형식 설정
    start = datetime.strptime(start_date, date_format)
    end = datetime.strptime(end_date, date_format)

    # 시작일부터 종료일까지의 날짜 범위 생성
    date_list = []
    while start <= end:
        date_list.append(int(start.strftime(date_format)))
        start += timedelta(days=1)

    return date_list


start_date = "20120128"
end_date = "20230614"
day_list = generate_date_range(start_date, end_date)

base_url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
output_folder = "./output/DailyMovie/"
# 폴더 생성
os.makedirs(output_folder, exist_ok=True)
for targetDt in day_list:
    params = {
        "key": "242670267f53f0939f64bf65a6bdce00",
        # 이거 쓰면 안 될 거 같은 키 : f5eef3421c602c6cb7ea224104795888
        # 1번키 : ce7448dc379b23c7211a7097cbe56e54
        # 2번키 : 242670267f53f0939f64bf65a6bdce00
        "targetDt": str(targetDt)
    }

    response = requests.get(base_url, params=params)
    data = response.json()

    output_filename = f"openAPI{targetDt}.json"
    output_path = output_folder + output_filename

    with open(output_path, "w", encoding="utf-8") as file:
        json.dump(data, file, ensure_ascii=False)

    print("now : ", end="")
    print(targetDt)
