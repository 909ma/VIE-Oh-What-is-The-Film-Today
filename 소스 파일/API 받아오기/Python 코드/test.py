'''
평점 받아오기
'''

import requests

# TMDB API 키
api_key = 'e2a56aa6721d47327a92acc02bfbddf3'


# 영화 이름
movie_name = '범죄도시 3'

# API 요청 URL
url = f'https://api.themoviedb.org/3/search/movie?api_key={api_key}&query={movie_name}'

# API 요청 보내기
response = requests.get(url)

# 응답 데이터 확인
if response.status_code == 200:
    search_results = response.json()
    if search_results['total_results'] > 0:
        # 검색 결과에서 첫 번째 영화 선택
        movie = search_results['results'][0]
        movie_id = movie['id']

        # 영화 상세 정보 요청 URL
        movie_url = f'https://api.themoviedb.org/3/movie/{movie_id}?api_key={api_key}'

        # 영화 상세 정보 요청 보내기
        movie_response = requests.get(movie_url)

        # 영화 평점 확인
        if movie_response.status_code == 200:
            movie_data = movie_response.json()
            rating = movie_data['vote_average']
            print(f"영화 '{movie_name}'의 평점: {rating}")
        else:
            print('영화 상세 정보 요청에 실패하였습니다.')
    else:
        print(f"'{movie_name}'에 대한 검색 결과가 없습니다.")
else:
    print('영화 검색 요청에 실패하였습니다.')
