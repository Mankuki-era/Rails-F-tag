[
  ['はじめたて', '週3回はジムに行って運動しようと思います。'],
  ['きつそうだなぁ', '1週間後に期末試験があります。全然勉強してなかったから本気で頑張ります。'],
  ['怖かった...', '今日は初めてスキーに行ったよ。初級者コースはまだ大丈夫だったけど、中級者はもう怖くて笑。でも絶対に上手くなってやる！']
].each do |title, content|
  Post.create!(
    { title: title, content: content}
  )
  end