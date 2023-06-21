import pymysql
from datetime import datetime, timedelta
import requests
import os
import json
import time

def generate_date_range(start_date, end_date):
    date_format = "%Y%m%d"
    start = datetime.strptime(start_date, date_format)
    end = datetime.strptime(end_date, date_format)

    date_list = []
    while start <= end:
        date_list.append(int(start.strftime(date_format)))
        start += timedelta(days=1)

    return date_list


# 입력 받은 시작 날짜와 끝 날짜
start_date = input("시작 날짜를 입력하세요 (YYYYMMDD): ")
end_date = input("끝 날짜를 입력하세요 (YYYYMMDD): ")

day_list = generate_date_range(start_date, end_date)

base_url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
output_folder = "./output/DailyMovie/"

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

    print("Write now : ", end="")
    print(targetDt)

# DB 연결
conn = pymysql.connect(
    host='localhost',
    user='root',
    password='1234',
    db='myproject',
    charset='utf8'
)

# SQL 쿼리
select_sql = 'SELECT * FROM DailyMovie WHERE targetDt = %s'
insert_sql = 'INSERT INTO DailyMovie VALUES (%s, %d, "%s", "%s", %d, %d, %d, %d, %d, %d)'

cur = conn.cursor()

# 날짜별로 데이터 처리
for day in day_list:
    # 이미 해당 날짜의 데이터가 있는지 확인
    cur.execute(select_sql % str(day))
    result = cur.fetchone()

    # 해당 날짜의 데이터가 없는 경우에만 INSERT 쿼리 실행
    if not result:
        # 파일 경로 생성
        filename = f'./output/DailyMovie/openAPI{day}.json'

        # JSON 파일 읽기
        with open(filename, encoding='utf-8') as f:
            json_object = json.load(f)

        # 데이터 처리
        json_arr = json_object['boxOfficeResult']['dailyBoxOfficeList']
        for item in json_arr:
            movieCd = int(item['movieCd']) * (100000000) + day
            cur.execute(insert_sql % (
                str(movieCd),
                int(item['movieCd']),
                item['movieNm'],
                item['openDt'],
                int(item['rank']),
                int(item['salesAmt']),
                int(item['salesAcc']),
                int(item['audiCnt']),
                int(item['audiAcc']),
                day)
                        )
    print("Read now : ", end="")
    print(day)
# 변경사항 커밋 및 연결 종료
conn.commit()
conn.close()

print()
print("Success")
time.sleep(10)
exit()