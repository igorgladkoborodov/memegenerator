class Coub < ActiveRecord::Base
  belongs_to :user

  def client
    @_client ||= user.client
  end

  def url
    "http://coub.com/view/#{ permalink }"
  end

  def escape_ffmpeg_text(text)
    text.
      to_s.
      gsub("'", "\\\\\\\\\\\\\\\\\\\\\\\\'").
      gsub(":", "\\\\\\\\\\\\\\\\:").
      mb_chars.
      upcase # Crazy ffmpeg escaping
  end

  def ffmpeg_drawtext(text, from, to)
    font_file =
      Rails.root.join('app', 'assets', 'fonts', 'PFDinTextCondPro-XBlack.ttf')

    "drawtext=enable='between(t,#{ from },#{ to })':" +
    "text=#{escape_ffmpeg_text(text)}:fontfile=#{ font_file }:fontsize=40:"
    "fontcolor=white:x=(w-tw)/2:y=(h*0.9-th)"
  end

  def generate_video_file
    self.video_file = Rails.root.join('tmp', "output-#{ Time.now.to_i }.mp4")
    template_file = Rails.root.join('app', 'assets', 'videos', 'template.mp4')

    cmd =
      "ffmpeg -i #{ template_file } -vf \"#{ ffmpeg_drawtext(text1, 1, 2) }, " +
      "#{ ffmpeg_drawtext(text2, 3, 5) }, #{ ffmpeg_drawtext(text3, 6.3, 8) }" +
      "\" #{ video_file }"

    `#{ cmd }`
  end

  def upload_video
    self.title ||= text2
    self.visibility_type ||= 'private'
    self.tags ||= ''

    init_response = JSON.parse(client.post('coubs/init_upload').body)
    self.coub_id = init_response['id']
    self.permalink = init_response['permalink']

    save

    client.post do |r|
      r.url "coubs/#{ coub_id }/upload_video"
      r.headers['Content-Type'] = 'video/mp4'
      r.body = File.open(video_file, 'r').read
    end

    client.post(
      "coubs/#{ coub_id }/finalize_upload",
      title: title,
      original_visibility_type: visibility_type,
      tags: tags,
      sound_enabled: true
    )
  end

  def generate_and_upload_video
    generate_video_file
    upload_video
  end
end
