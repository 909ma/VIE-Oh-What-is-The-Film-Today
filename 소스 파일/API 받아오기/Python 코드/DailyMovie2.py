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


# Read API key from ApiKey.json file
with open("ApiKey.json", "r", encoding="utf-8") as api_file:
    api_data = json.load(api_file)
api_key = api_data["key"]

# 모드 입력
print("모드를 입력하세요")
print("읽기 모드(데이터베이스로 저장) : 1")
print("쓰기 모드(데이터 받아오기) : 2")
print("둘 다(데이터 받아서 DB에 저장) : 3")

modeNum = int(input())
print(modeNum)
if modeNum != 1 and modeNum != 2 and modeNum != 3:
    print("잘못된 입력입니다.")
    time.sleep(3)
    exit()

# 입력 받은 시작 날짜와 끝 날짜
start_date = input("시작 날짜를 입력하세요 (YYYYMMDD): ")
end_date = input("끝 날짜를 입력하세요 (YYYYMMDD): ")

day_list = generate_date_range(start_date, end_date)

if modeNum != 1:
    base_url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    output_folder = "./output/DailyMovie/"

    # 폴더 생성
    os.makedirs(output_folder, exist_ok=True)
    for targetDt in day_list:
        params = {
            "key": api_key,
            "targetDt": str(targetDt)
        }

        response = requests.get(base_url, params=params)
        data = response.json()

        output_filename = f"openAPI{targetDt}.json"
        output_path = output_folder + output_filename

        with open(output_path, "w", encoding="utf-8") as file:
            json.dump(data, file, ensure_ascii=False)

        print("Write now:", targetDt)

if modeNum != 2:
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
        try:
            cur.execute(select_sql % str(day))
            result = cur.fetchone()

            if not result:
                filename = f'./output/DailyMovie/openAPI{day}.json'

                with open(filename, encoding='utf-8') as f:
                    json_object = json.load(f)

                json_arr = json_object['boxOfficeResult']['dailyBoxOfficeList']
                for item in json_arr:
                    if item['movieCd'] == '2009A362':
                        movieCd = 99999999 * 100000000 + day
                    else:
                        movieCd = int(item['movieCd']) * 100000000 + day
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

            print("Read now: ", end="")
            print(day)
        except Exception as e:
            # 오류가 발생한 날짜와 오류 메시지 출력
            print("오류 발생:", day)
            print("오류 메시지:", str(e))

    # 변경사항 커밋 및 연결 종료
    conn.commit()
    conn.close()

print()
print("Success")
time.sleep(10)
exit()
