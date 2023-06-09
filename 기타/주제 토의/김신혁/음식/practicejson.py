import json
import pymysql

"""
생성된 api 데이터 파일로부터 MySQL 연동
"""
# 파일 이름 규칙에 따라 연도 리스트 생성
year_list = list(range(2005, 2024))

# 연도별로 파일을 읽고 처리
for year in year_list:
    # JSON 파일 경로 생성
    filename = f'./output/openAPI{year}.json'  # 파일 경로 수정

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
    sql = 'INSERT INTO practice VALUES (%d, "%s", "%s", %d, %d)'

    # 데이터 처리
    json_arr = json_object['list']
    cur = conn.cursor()
    for item in json_arr:
        print(item)
        cur.execute(sql % (
            int(item['amount']),
            item['itemkname'],
            item['itemspec'],
            int(item['year']),
            int(item['itemcode']) + year*1000
        ))

    conn.commit()
    conn.close()
