1 将该行

let fmt = get(g:, 'plug_url_format', 'https://git::@github.com/%s.git')
 改为

let fmt = get(g:, 'plug_url_format', 'https://git::@hub.fastgit.org/%s.git')
2 将改行

\ '^https://git::@github\.com', 'https://github.com', '')
改为

\ '^https://git::@hub.fastgit\.org', 'https://hub.fastgit.org', '')
上述两个步骤的目是让镜像网站代替实际网站, 这样能有效提高下载成功率。
