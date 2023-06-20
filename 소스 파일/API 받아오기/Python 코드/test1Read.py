'''
자꾸 에러 나는거 잡기 위해 새로 만든 코드
읽기만 된다
'''

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

# 오류가 난 파일들의 이름을 저장할 리스트
error_files = []
# DB 연결
conn = pymysql.connect(
    host='localhost',
    user='root',
    password='1234',
    db='myproject',
    charset='utf8'
)

select_sql = 'SELECT * FROM DailyMovie WHERE targetDt = %s'
insert_sql = 'INSERT INTO DailyMovie VALUES (%s, %d, "%s", "%s", %d, %d, %d, %d, %d, %d)'

cur = conn.cursor()

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

conn.commit()
conn.close()

# 오류가 발생한 파일들의 이름 출력
if error_files:
    print("오류가 발생한 파일들:")
    for file in error_files:
        print(file)
else:
    print("오류가 발생한 파일이 없습니다.")

print()
print("Success")
time.sleep(10)
exit()