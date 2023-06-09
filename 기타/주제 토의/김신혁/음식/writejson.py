import requests
import json
import os
import json

"""
http://www.chungnam.go.kr/cnnet/content.do?mnu_cd=CNNMENU02031
api 데이터 받아와서 파일 생성
"""


base_url = "https://chungnam.go.kr/realprice/openApi.do"
output_folder = "./output/"
# 폴더 생성
os.makedirs(output_folder, exist_ok=True)
for year in range(2005, 2024):
    params = {
        "code": "102",
        "year": str(year),
        "month": "05",
        "no": "2",
        "cnarea_cd": "A01"
    }

    response = requests.get(base_url, params=params)
    data = response.json()

    output_filename = f"openAPI{year}.json"
    output_path = output_folder + output_filename

    with open(output_path, "w", encoding="utf-8") as file:
        json.dump(data, file, ensure_ascii=False)
