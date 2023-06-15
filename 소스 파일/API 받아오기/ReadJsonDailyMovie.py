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


import json
import pymysql

"""
생성된 api 데이터 파일로부터 MySQL 연동
"""
# 파일 이름 규칙에 따라 연도 리스트 생성
start_date = "20230101"
end_date = "20230613"
day_list = generate_date_range(start_date, end_date)

# 연도별로 파일을 읽고 처리
for day in day_list:
    # JSON 파일 경로 생성
    filename = f'./output/DailyMovie/openAPI{day}.json'  # 파일 경로 수정

    # JSON 파일 읽기
    with open(filename, encoding='utf-8') as f:
        json_object = json.load(f)

    print(json_object)

    # DB 연결
    conn = pymysql.connect(
        host='localhost',
        user='root',
        password='1234',
        db='myproject',
        charset='utf8'
    )

    # SQL 쿼리
    sql = 'INSERT INTO DailyMovie VALUES (%s, %d, "%s", "%s", %d, %d, %d, %d, %d, %d)'

    # 데이터 처리
    json_arr = json_object['boxOfficeResult']['dailyBoxOfficeList']
    cur = conn.cursor()
    for item in json_arr:
        print(item)
        movieCd = int(item['movieCd']) * (100000000) + day
        cur.execute(sql % (
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

    conn.commit()
    conn.close()
