'''
https://www.kobis.or.kr/
'''
from datetime import datetime, timedelta


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


import requests
import json
import os
import json

start_date = "20230101"
end_date = "20230430"
day_list = generate_date_range(start_date, end_date)

base_url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
output_folder = "./output/"
# 폴더 생성
os.makedirs(output_folder, exist_ok=True)
for targetDt in day_list:
    params = {
        "key": "f5eef3421c602c6cb7ea224104795888",
        # 이거 쓰면 안 될 거 같은 키 : f5eef3421c602c6cb7ea224104795888
        "targetDt": str(targetDt)
    }

    response = requests.get(base_url, params=params)
    data = response.json()

    output_filename = f"openAPI{targetDt}.json"
    output_path = output_folder + output_filename

    with open(output_path, "w", encoding="utf-8") as file:
        json.dump(data, file, ensure_ascii=False)
