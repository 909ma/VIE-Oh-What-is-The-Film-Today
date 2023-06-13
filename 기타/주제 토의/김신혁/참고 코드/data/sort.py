import json

# list.json 파일 읽기
with open('list.json', encoding='utf-8') as file:
    json_data = file.read()

# JSON 데이터 파싱
data = json.loads(json_data)

# reviewList를 제목(title)을 기준으로 오름차순 정렬
sorted_list = sorted(data, key=lambda x: x["title"])

# 정렬된 결과를 list.json 파일에 저장
with open('list.json', 'w', encoding='utf-8') as file:
    file.write(json.dumps(sorted_list, indent=2, ensure_ascii=False))

print("list.json 파일에 정렬된 결과를 저장했습니다.")
