class GthreadsController < ApplicationController
  before_action :login_check, :set_user_id_to_cookie
  before_action :is_com_participant?, only: [:index, :show_additionally]
  before_action :channel_public_check, only: [:index, :show_additionally]
  before_action :is_gthread_author?, only: :destroy
  
  def index
    @user = current_user
    
    @gthread = Gthread.new
    
    @communities = current_user.communities
    
    if params[:channel_id] && Channel.exists?(id: params[:channel_id])
      @channel = Channel.find(params[:channel_id])
    else
      redirect_to channels_gthreads_path(current_user.communities.order(:created_at).first.channels.first.id)
      @community_first = Community.find(current_user.communities.order(:created_at).first.id)
      @channel = Channel.find(@community_first.channels.first.id)
    end
    
    @gthreads = @channel.gthreads.includes(:user, :thread_reaction_users, :thread_reactions).order(:created_at).last(4)
    
    gon.channel_id = @channel.id
    gon.current_user_id = current_user.id
    
    @unchecked_notifications = current_user.passive_notifications.where(checked: false).where.not(visitor_id: current_user.id)
  end
  
  def create
    @gthread = Gthread.new(thread_params)
    @gthread.user_id = current_user.id
    @channel = Channel.find_by(id: thread_params[:channel_id])
    @gthread.save
    
    ActionCable.server.broadcast "gthread_channel_#{ @channel.id }", my_gthread: @gthread.my_gthread, others_gthread: @gthread.others_gthread,
        gthread_id: @gthread['id'], channel_id: @gthread['channel_id'], user_id: @gthread.user_id, title: @gthread.title,
        gthread_user_name: @gthread.user.accountName, gthread_user_images: @gthread.user.images.url, gthread_user_self_introduction: @gthread.user.self_introduction,
        gthread_user_communities_count: @gthread.user.communities.count, gthread_user_created_at: @gthread.user.created_at.strftime("%-Y#{'年'}%-m#{'月'}"),
        channel_name: @gthread.channel.channelName, channel_color: @gthread.channel.color,
        community_participant_id: @gthread.channel.community.users.find(@gthread.user_id).id
    
    # 通知機能
    # 公開チャンネルのスレッドの場合、同じコミュニティー参加者全員に通知を知らせる
    if @gthread.channel.public == 2
      temp_ids = @gthread.channel.community.users.select(:id).where.not(id: current_user.id).distinct
    elsif @gthread.channel.public == 1
      temp_ids = @gthread.channel.community.users.select(:id).where(community_participants: { role: 1 }).where.not(id: current_user.id).distinct
    end
    
    temp_ids.each do |temp_id|
      notification = current_user.active_notifications.new(
        gthread_id: @gthread.id,
        visited_id: temp_id['id'],#@gthread.channel.community.users,#visited_id,
        action: 'gthread'
      )
      # 自分の投稿したスレッドの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  def notification_index
    @notifications = current_user.passive_notifications.where(checked: false)
  end
  
  def reaction_image_index
    @gthread = Gthread.find(params[:id])
    
    @reaction_images_custom = [
      { emoji_id: '1', entity_name: 'ryokai', images: "/reaction_images/custom/ryokai.png" },
      { emoji_id: '1', entity_name: 'ryo', images: "/reaction_images/custom/ryo.png" },
      { emoji_id: '1', entity_name: 'oke', images: "/reaction_images/custom/oke.png" },
      { emoji_id: '1', entity_name: 'sorena', images: "/reaction_images/custom/sorena.png" },
      { emoji_id: '1', entity_name: 'shochi_shimashita', images: "/reaction_images/custom/shochi_shimashita.png" },
      { emoji_id: '1', entity_name: 'kakunin_shimashita', images: "/reaction_images/custom/kakunin_shimashita.png" },
      { emoji_id: '1', entity_name: 'kakunin_chu', images: "/reaction_images/custom/kakunin_chu.png" },
      { emoji_id: '1', entity_name: 'kakunin_zumi', images: "/reaction_images/custom/kakunin_zumi.png" },
      { emoji_id: '1', entity_name: 'shosho_omachikudasai', images: "/reaction_images/custom/shosho_omachikudasai.png" },
      { emoji_id: '1', entity_name: 'choimachi', images: "/reaction_images/custom/choimachi.png" },
      { emoji_id: '1', entity_name: 'done', images: "/reaction_images/custom/done.png" },
      { emoji_id: '1', entity_name: 'iine', images: "/reaction_images/custom/iine.png" },
      { emoji_id: '1', entity_name: 'yoki', images: "/reaction_images/custom/yoki....png" },
      { emoji_id: '1', entity_name: 'otsukaresama', images: "/reaction_images/custom/otsukaresama.png" },
      { emoji_id: '1', entity_name: 'gokurosama', images: "/reaction_images/custom/gokurosama.png" },
      { emoji_id: '1', entity_name: 'kokiniwa', images: "/reaction_images/custom/kokiniwa.gif" },
    ]
    
    @reaction_images_smileys_and_emotion = [
      { emoji_id: '2', entity_name: 'nikkori', images: "/reaction_images/smileys_&_emotion/nikkori.png" },
      { emoji_id: '2', entity_name: 'wai', images: "/reaction_images/smileys_&_emotion/wai.png" },
      { emoji_id: '2', entity_name: 'egao', images: "/reaction_images/smileys_&_emotion/egao.png" },
      { emoji_id: '2', entity_name: 'niyatto', images: "/reaction_images/smileys_&_emotion/niyatto.png" },
      { emoji_id: '2', entity_name: 'kya', images: "/reaction_images/smileys_&_emotion/kya.png" },
      { emoji_id: '2', entity_name: 'hiyaase_egao', images: "/reaction_images/smileys_&_emotion/hiyaase_egao.png" },
      { emoji_id: '2', entity_name: 'ureshinaki', images: "/reaction_images/smileys_&_emotion/ureshinaki.png" },
      { emoji_id: '2', entity_name: 'waraikoroge', images: "/reaction_images/smileys_&_emotion/waraikoroge.png" },
      { emoji_id: '2', entity_name: 'nikoniko', images: "/reaction_images/smileys_&_emotion/nikoniko.png" },
      { emoji_id: '2', entity_name: 'tenshinowa', images: "/reaction_images/smileys_&_emotion/tenshinowa.png" },
      { emoji_id: '2', entity_name: 'hohoemi', images: "/reaction_images/smileys_&_emotion/hohoemi.png" },
      { emoji_id: '2', entity_name: 'sakasama_no_kao', images: "/reaction_images/smileys_&_emotion/sakasama_no_kao.png" },
      { emoji_id: '2', entity_name: 'wink', images: "/reaction_images/smileys_&_emotion/wink.png" },
      { emoji_id: '2', entity_name: 'hottoshita_kao', images: "/reaction_images/smileys_&_emotion/hottoshita_kao.png" },
      { emoji_id: '2', entity_name: 'mega_heart', images: "/reaction_images/smileys_&_emotion/mega_heart.png" },
      { emoji_id: '2', entity_name: 'heart_no_egao', images: "/reaction_images/smileys_&_emotion/heart_no_egao.png" },
      { emoji_id: '2', entity_name: 'nagekiss', images: "/reaction_images/smileys_&_emotion/nagekiss.png" },
      { emoji_id: '2', entity_name: 'nikkori_kiss', images: "/reaction_images/smileys_&_emotion/nikkori_kiss.png" },
      { emoji_id: '2', entity_name: 'chu', images: "/reaction_images/smileys_&_emotion/chu.png" },
      { emoji_id: '2', entity_name: 'nikoniko_perori', images: "/reaction_images/smileys_&_emotion/nikoniko_perori.png" },
      { emoji_id: '2', entity_name: 'be', images: "/reaction_images/smileys_&_emotion/be.png" },
      { emoji_id: '2', entity_name: 'mewotojite_be', images: "/reaction_images/smileys_&_emotion/mewotojite_be.png" },
      { emoji_id: '2', entity_name: 'akkan_be', images: "/reaction_images/smileys_&_emotion/akkan_be.png" },
      { emoji_id: '2', entity_name: 'huzaketa_kao', images: "/reaction_images/smileys_&_emotion/huzaketa_kao.png" },
      { emoji_id: '2', entity_name: 'okaneno_kao', images: "/reaction_images/smileys_&_emotion/okaneno_kao.png" },
      { emoji_id: '2', entity_name: 'monocle_wotsuketa_kao', images: "/reaction_images/smileys_&_emotion/monocle_wotsuketa_kao.png" },
      { emoji_id: '2', entity_name: 'otaku', images: "/reaction_images/smileys_&_emotion/otaku.png" },
      { emoji_id: '2', entity_name: 'sunglass_de_egao', images: "/reaction_images/smileys_&_emotion/sunglass_de_egao.png" },
      { emoji_id: '2', entity_name: 'megahoshino_egao', images: "/reaction_images/smileys_&_emotion/megahoshino_egao.png" },
      { emoji_id: '2', entity_name: 'party_no_kao', images: "/reaction_images/smileys_&_emotion/party_no_kao.png" },
      { emoji_id: '2', entity_name: 'cowboy', images: "/reaction_images/smileys_&_emotion/cowboy.png" },
      { emoji_id: '2', entity_name: 'henso', images: "/reaction_images/smileys_&_emotion/henso.png" },
      { emoji_id: '2', entity_name: 'usuwaraino_kao', images: "/reaction_images/smileys_&_emotion/usuwaraino_kao.png" },
      { emoji_id: '2', entity_name: 'shiraketa_kao', images: "/reaction_images/smileys_&_emotion/shiraketa_kao.png" },
      { emoji_id: '2', entity_name: 'shitsuboshita_kao', images: "/reaction_images/smileys_&_emotion/shitsuboshita_kao.png" },
      { emoji_id: '2', entity_name: 'monoomoino_kao', images: "/reaction_images/smileys_&_emotion/monoomoino_kao.png" },
      { emoji_id: '2', entity_name: 'nayamu_kao', images: "/reaction_images/smileys_&_emotion/nayamu_kao.png" },
      { emoji_id: '2', entity_name: 'konranshita_kao', images: "/reaction_images/smileys_&_emotion/konranshita_kao.png" },
      { emoji_id: '2', entity_name: 'sukoshikomatta_kao', images: "/reaction_images/smileys_&_emotion/sukoshikomatta_kao.png" },
      { emoji_id: '2', entity_name: 'gamanshita_kao', images: "/reaction_images/smileys_&_emotion/gamanshita_kao.png" },
      { emoji_id: '2', entity_name: 'konwakushita_kao', images: "/reaction_images/smileys_&_emotion/konwakushita_kao.png" },
      { emoji_id: '2', entity_name: 'tsukareta_kao', images: "/reaction_images/smileys_&_emotion/tsukareta_kao.png" },
      { emoji_id: '2', entity_name: 'unzarishita_kao', images: "/reaction_images/smileys_&_emotion/unzarishita_kao.png" },
      { emoji_id: '2', entity_name: 'nakigao', images: "/reaction_images/smileys_&_emotion/nakigao.png" },
      { emoji_id: '2', entity_name: 'onaki', images: "/reaction_images/smileys_&_emotion/onaki.png" },
      { emoji_id: '2', entity_name: 'hanaikinoarai_kao', images: "/reaction_images/smileys_&_emotion/hanaikinoarai_kao.png" },
      { emoji_id: '2', entity_name: 'okotta_kao', images: "/reaction_images/smileys_&_emotion/okotta_kao.png" },
      { emoji_id: '2', entity_name: 'hukurettsura', images: "/reaction_images/smileys_&_emotion/hukurettsura.png" },
      { emoji_id: '2', entity_name: 'nonoshitta_kao', images: "/reaction_images/smileys_&_emotion/nonoshitta_kao.png" },
      { emoji_id: '2', entity_name: 'atamaga_bakuhatsushita_kao', images: "/reaction_images/smileys_&_emotion/atamaga_bakuhatsushita_kao.png" },
      { emoji_id: '2', entity_name: 'atsui_kao', images: "/reaction_images/smileys_&_emotion/atsui_kao.png" },
      { emoji_id: '2', entity_name: 'samui_kao', images: "/reaction_images/smileys_&_emotion/samui_kao.png" },
      { emoji_id: '2', entity_name: 'aozameta_kao', images: "/reaction_images/smileys_&_emotion/aozameta_kao.png" },
      { emoji_id: '2', entity_name: 'aozame_hiyaase', images: "/reaction_images/smileys_&_emotion/aozame_hiyaase.png" },
      { emoji_id: '2', entity_name: 'kyohu', images: "/reaction_images/smileys_&_emotion/kyohu.png" },
      { emoji_id: '2', entity_name: 'doshiyo', images: "/reaction_images/smileys_&_emotion/doshiyo.png" },
      { emoji_id: '2', entity_name: 'hiyaase', images: "/reaction_images/smileys_&_emotion/hiyaase.png" },
      { emoji_id: '2', entity_name: 'hug', images: "/reaction_images/smileys_&_emotion/hug.png" },
      { emoji_id: '2', entity_name: 'kangaechu', images: "/reaction_images/smileys_&_emotion/kangaechu.png" },
      { emoji_id: '2', entity_name: 'kuchinitewoateta_kao', images: "/reaction_images/smileys_&_emotion/kuchinitewoateta_kao.png" },
      { emoji_id: '2', entity_name: 'shi', images: "/reaction_images/smileys_&_emotion/shi.png" },
      { emoji_id: '2', entity_name: 'kuchichack', images: "/reaction_images/smileys_&_emotion/kuchichack.png" },
      { emoji_id: '2', entity_name: 'usotsukino_kao', images: "/reaction_images/smileys_&_emotion/usotsukino_kao.png" },
      { emoji_id: '2', entity_name: 'kuchinonai_kao', images: "/reaction_images/smileys_&_emotion/kuchinonai_kao.png" },
      { emoji_id: '2', entity_name: 'pokerface', images: "/reaction_images/smileys_&_emotion/pokerface.png" },
      { emoji_id: '2', entity_name: 'muhyojo', images: "/reaction_images/smileys_&_emotion/muhyojo.png" },
      { emoji_id: '2', entity_name: 'shikametsura', images: "/reaction_images/smileys_&_emotion/shikametsura.png" },
      { emoji_id: '2', entity_name: 'gyorome', images: "/reaction_images/smileys_&_emotion/gyorome.png" },
      { emoji_id: '2', entity_name: 'mayuwoageta_kao', images: "/reaction_images/smileys_&_emotion/mayuwoageta_kao.png" },
      { emoji_id: '2', entity_name: 'odoroita_kao', images: "/reaction_images/smileys_&_emotion/odoroita_kao.png" },
      { emoji_id: '2', entity_name: 'akiregao', images: "/reaction_images/smileys_&_emotion/akiregao.png" },
      { emoji_id: '2', entity_name: 'kuno', images: "/reaction_images/smileys_&_emotion/kuno.png" },
      { emoji_id: '2', entity_name: 'kuchigahiraita_kao', images: "/reaction_images/smileys_&_emotion/kuchigahiraita_kao.png" },
      { emoji_id: '2', entity_name: 'bikkurishita_kao', images: "/reaction_images/smileys_&_emotion/bikkurishita_kao.png" },
      { emoji_id: '2', entity_name: 'sekimenshita_kao', images: "/reaction_images/smileys_&_emotion/sekimenshita_kao.png" },
      { emoji_id: '2', entity_name: 'uttaekakeru_kao', images: "/reaction_images/smileys_&_emotion/uttaekakeru_kao.png" },
      { emoji_id: '2', entity_name: 'nemui_kao', images: "/reaction_images/smileys_&_emotion/nemui_kao.png" },
      { emoji_id: '2', entity_name: 'neteru_kao', images: "/reaction_images/smileys_&_emotion/neteru_kao.png" },
      { emoji_id: '2', entity_name: 'yodaregao', images: "/reaction_images/smileys_&_emotion/yodaregao.png" },
      { emoji_id: '2', entity_name: 'bonyarishita_kao', images: "/reaction_images/smileys_&_emotion/bonyarishita_kao.png" },
      { emoji_id: '2', entity_name: 'memaigao', images: "/reaction_images/smileys_&_emotion/memaigao.png" },
      { emoji_id: '2', entity_name: 'hakike', images: "/reaction_images/smileys_&_emotion/hakike.png" },
      { emoji_id: '2', entity_name: 'oto', images: "/reaction_images/smileys_&_emotion/oto.png" },
      { emoji_id: '2', entity_name: 'kushamigao', images: "/reaction_images/smileys_&_emotion/kushamigao.png" },
      { emoji_id: '2', entity_name: 'mask_gao', images: "/reaction_images/smileys_&_emotion/mask_gao.png" },
      { emoji_id: '2', entity_name: 'hatsunetsu', images: "/reaction_images/smileys_&_emotion/hatsunetsu.png" },
      { emoji_id: '2', entity_name: 'hotaiwomaita_kao', images: "/reaction_images/smileys_&_emotion/hotaiwomaita_kao.png" },
      { emoji_id: '2', entity_name: 'waratta_akuma', images: "/reaction_images/smileys_&_emotion/waratta_akuma.png" },
      { emoji_id: '2', entity_name: 'okotta_akuma', images: "/reaction_images/smileys_&_emotion/okotta_akuma.png" },
      { emoji_id: '2', entity_name: 'pierrot', images: "/reaction_images/smileys_&_emotion/pierrot.png" },
      { emoji_id: '2', entity_name: 'obake', images: "/reaction_images/smileys_&_emotion/obake.png" },
      { emoji_id: '2', entity_name: 'dokuro', images: "/reaction_images/smileys_&_emotion/dokuro.png" },
      { emoji_id: '2', entity_name: 'alien', images: "/reaction_images/smileys_&_emotion/alien.png" },
      { emoji_id: '2', entity_name: 'two_hearts', images: "/reaction_images/smileys_&_emotion/two_hearts.png" },
      { emoji_id: '2', entity_name: 'growing_heart', images: "/reaction_images/smileys_&_emotion/growing_heart.png" },
      { emoji_id: '2', entity_name: 'heart_with_arrow', images: "/reaction_images/smileys_&_emotion/heart_with_arrow.png" },
      { emoji_id: '2', entity_name: 'broken_heart', images: "/reaction_images/smileys_&_emotion/broken_heart.png" },
      { emoji_id: '2', entity_name: '100tenmanten', images: "/reaction_images/smileys_&_emotion/100tenmanten.png" },
      { emoji_id: '2', entity_name: 'taihen_yokudekimashita', images: "/reaction_images/smileys_&_emotion/taihen_yokudekimashita.png" },
      { emoji_id: '2', entity_name: 'sparkles', images: "/reaction_images/smileys_&_emotion/sparkles.png" },
      { emoji_id: '2', entity_name: 'sweat_droplets', images: "/reaction_images/smileys_&_emotion/sweat_droplets.png" },
      { emoji_id: '2', entity_name: 'ikari_mark', images: "/reaction_images/smileys_&_emotion/ikari_mark.png" },
      { emoji_id: '2', entity_name: 'zzz', images: "/reaction_images/smileys_&_emotion/zzz.png" },
    ]
    
    @reaction_images_body_and_gesture_and_person = [
      { emoji_id: '3', entity_name: 'palms_up_together', images: "/reaction_images/body_&_gesture_&_person/palms_up_together.png" },
      { emoji_id: '3', entity_name: 'open_hands', images: "/reaction_images/body_&_gesture_&_person/open_hands.png" },
      { emoji_id: '3', entity_name: 'banzai', images: "/reaction_images/body_&_gesture_&_person/banzai.png" },
      { emoji_id: '3', entity_name: 'clapping_hands', images: "/reaction_images/body_&_gesture_&_person/clapping_hands.png" },
      { emoji_id: '3', entity_name: 'handshake', images: "/reaction_images/body_&_gesture_&_person/handshake.png" },
      { emoji_id: '3', entity_name: 'thumbs_up', images: "/reaction_images/body_&_gesture_&_person/thumbs_up.png" },
      { emoji_id: '3', entity_name: 'thumbs_down', images: "/reaction_images/body_&_gesture_&_person/thumbs_down.png" },
      { emoji_id: '3', entity_name: 'gu', images: "/reaction_images/body_&_gesture_&_person/gu.png" },
      { emoji_id: '3', entity_name: 'genkotsu', images: "/reaction_images/body_&_gesture_&_person/genkotsu.png" },
      { emoji_id: '3', entity_name: 'hidarimuki_no_kobushi', images: "/reaction_images/body_&_gesture_&_person/hidarimuki_no_kobushi.png" },
      { emoji_id: '3', entity_name: 'migimuki_no_kobushi', images: "/reaction_images/body_&_gesture_&_person/migimuki_no_kobushi.png" },
      { emoji_id: '3', entity_name: 'crossed_fingers', images: "/reaction_images/body_&_gesture_&_person/crossed_fingers.png" },
      { emoji_id: '3', entity_name: 'v_sign', images: "/reaction_images/body_&_gesture_&_person/v_sign.png" },
      { emoji_id: '3', entity_name: 'love_you_gesture', images: "/reaction_images/body_&_gesture_&_person/love_you_gesture.png" },
      { emoji_id: '3', entity_name: 'metal_pose', images: "/reaction_images/body_&_gesture_&_person/metal_pose.png" },
      { emoji_id: '3', entity_name: 'ok_sign', images: "/reaction_images/body_&_gesture_&_person/ok_sign.png" },
      { emoji_id: '3', entity_name: 'raised_hand', images: "/reaction_images/body_&_gesture_&_person/raised_hand.png" },
      { emoji_id: '3', entity_name: 'hiraita_te', images: "/reaction_images/body_&_gesture_&_person/hiraita_te.png" },
      { emoji_id: '3', entity_name: 'spock_hand', images: "/reaction_images/body_&_gesture_&_person/spock_hand.png" },
      { emoji_id: '3', entity_name: 'waving_hand', images: "/reaction_images/body_&_gesture_&_person/waving_hand.png" },
      { emoji_id: '3', entity_name: 'call_me_hand', images: "/reaction_images/body_&_gesture_&_person/call_me_hand.png" },
      { emoji_id: '3', entity_name: 'chikarakobu', images: "/reaction_images/body_&_gesture_&_person/chikarakobu.png" },
      { emoji_id: '3', entity_name: 'writing_hand', images: "/reaction_images/body_&_gesture_&_person/writing_hand.png" },
      { emoji_id: '3', entity_name: 'folded_hands', images: "/reaction_images/body_&_gesture_&_person/folded_hands.png" },
      { emoji_id: '3', entity_name: 'ashiato', images: "/reaction_images/body_&_gesture_&_person/ashiato.png" },
      { emoji_id: '3', entity_name: 'katame', images: "/reaction_images/body_&_gesture_&_person/katame.png" },
      { emoji_id: '3', entity_name: 'ryome', images: "/reaction_images/body_&_gesture_&_person/ryome.png" },
      { emoji_id: '3', entity_name: 'ojigi_man', images: "/reaction_images/body_&_gesture_&_person/ojigi_man.png" },
      { emoji_id: '3', entity_name: 'ojigi_woman', images: "/reaction_images/body_&_gesture_&_person/ojigi_woman.png" },
      { emoji_id: '3', entity_name: 'goannai_man', images: "/reaction_images/body_&_gesture_&_person/goannai_man.png" },
      { emoji_id: '3', entity_name: 'goannai_woman', images: "/reaction_images/body_&_gesture_&_person/goannai_woman.png" },
      { emoji_id: '3', entity_name: 'ok_pose_man', images: "/reaction_images/body_&_gesture_&_person/ok_pose_man.png" },
      { emoji_id: '3', entity_name: 'ok_pose_woman', images: "/reaction_images/body_&_gesture_&_person/ok_pose_woman.png" },
      { emoji_id: '3', entity_name: 'no_pose_man', images: "/reaction_images/body_&_gesture_&_person/no_pose_man.png" },
      { emoji_id: '3', entity_name: 'no_pose_woman', images: "/reaction_images/body_&_gesture_&_person/no_pose_woman.png" },
      { emoji_id: '3', entity_name: 'kyoshu_man', images: "/reaction_images/body_&_gesture_&_person/kyoshu_man.png" },
      { emoji_id: '3', entity_name: 'kyoshu_woman', images: "/reaction_images/body_&_gesture_&_person/kyoshu_woman.png" },
      { emoji_id: '3', entity_name: 'facepalming_man', images: "/reaction_images/body_&_gesture_&_person/facepalming_man.png" },
      { emoji_id: '3', entity_name: 'facepalming_woman', images: "/reaction_images/body_&_gesture_&_person/facepalming_woman.png" },
      { emoji_id: '3', entity_name: 'shrugging_man', images: "/reaction_images/body_&_gesture_&_person/shrugging_man.png" },
      { emoji_id: '3', entity_name: 'shrugging_woman', images: "/reaction_images/body_&_gesture_&_person/shrugging_woman.png" },
      { emoji_id: '3', entity_name: 'frowning_man', images: "/reaction_images/body_&_gesture_&_person/frowning_man.png" },
      { emoji_id: '3', entity_name: 'frowning_woman', images: "/reaction_images/body_&_gesture_&_person/frowning_woman.png" },
      { emoji_id: '3', entity_name: 'pouting_man', images: "/reaction_images/body_&_gesture_&_person/pouting_man.png" },
      { emoji_id: '3', entity_name: 'pouting_woman', images: "/reaction_images/body_&_gesture_&_person/pouting_woman.png" },
      { emoji_id: '3', entity_name: 'goannai_man', images: "/reaction_images/body_&_gesture_&_person/goannai_man.png" },
      { emoji_id: '3', entity_name: 'goannai_woman', images: "/reaction_images/body_&_gesture_&_person/goannai_woman.png" },
      { emoji_id: '3', entity_name: 'walking_man', images: "/reaction_images/body_&_gesture_&_person/walking_man.png" },
      { emoji_id: '3', entity_name: 'walking_woman', images: "/reaction_images/body_&_gesture_&_person/walking_woman.png" },
      { emoji_id: '3', entity_name: 'running_man', images: "/reaction_images/body_&_gesture_&_person/running_man.png" },
      { emoji_id: '3', entity_name: 'running_woman', images: "/reaction_images/body_&_gesture_&_person/running_woman.png" },
      { emoji_id: '3', entity_name: 'dancing_man', images: "/reaction_images/body_&_gesture_&_person/dancing_man.png" },
      { emoji_id: '3', entity_name: 'dancing_woman', images: "/reaction_images/body_&_gesture_&_person/dancing_woman.png" },
      { emoji_id: '3', entity_name: 'man_in_lotus_position', images: "/reaction_images/body_&_gesture_&_person/man_in_lotus_position.png" },
      { emoji_id: '3', entity_name: 'woman_in_lotus_position', images: "/reaction_images/body_&_gesture_&_person/woman_in_lotus_position.png" },
      { emoji_id: '3', entity_name: 'person_taking_bath', images: "/reaction_images/body_&_gesture_&_person/person_taking_bath.png" },
      { emoji_id: '3', entity_name: 'person_in_bed', images: "/reaction_images/body_&_gesture_&_person/person_in_bed.png" },
    ]
  
    @reaction_images_nature_and_place = [
      { emoji_id: '4', entity_name: 'sun_with_face', images: "/reaction_images/nature_&_place/sun_with_face.png" },
      { emoji_id: '4', entity_name: 'full_moon_with_face', images: "/reaction_images/nature_&_place/full_moon_with_face.png" },
      { emoji_id: '4', entity_name: 'full_moon', images: "/reaction_images/nature_&_place/full_moon.png" },
      { emoji_id: '4', entity_name: 'crescent_moon', images: "/reaction_images/nature_&_place/crescent_moon.png" },
      { emoji_id: '4', entity_name: 'ringed_planet', images: "/reaction_images/nature_&_place/ringed_planet.png" },
      { emoji_id: '4', entity_name: 'star', images: "/reaction_images/nature_&_place/star.png" },
      { emoji_id: '4', entity_name: 'glowing_star', images: "/reaction_images/nature_&_place/glowing_star.png" },
      { emoji_id: '4', entity_name: 'shooting_star', images: "/reaction_images/nature_&_place/shooting_star.png" },
      { emoji_id: '4', entity_name: 'milky_way', images: "/reaction_images/nature_&_place/milky_way.png" },
      { emoji_id: '4', entity_name: 'hare_tokidoki_kumori', images: "/reaction_images/nature_&_place/hare_tokidoki_kumori.png" },
      { emoji_id: '4', entity_name: 'kumori_tokidoki_hare', images: "/reaction_images/nature_&_place/kumori_tokidoki_hare.png" },
      { emoji_id: '4', entity_name: 'ame_tokidoki_hare', images: "/reaction_images/nature_&_place/ame_tokidoki_hare.png" },
      { emoji_id: '4', entity_name: 'cloud_with_rain', images: "/reaction_images/nature_&_place/cloud_with_rain.png" },
      { emoji_id: '4', entity_name: 'cloud_with_lightning_and_rain', images: "/reaction_images/nature_&_place/cloud_with_lightning_and_rain.png" },
      { emoji_id: '4', entity_name: 'cloud_with_lightning', images: "/reaction_images/nature_&_place/cloud_with_lightning.png" },
      { emoji_id: '4', entity_name: 'cloud_with_snow', images: "/reaction_images/nature_&_place/cloud_with_snow.png" },
      { emoji_id: '4', entity_name: 'snowman', images: "/reaction_images/nature_&_place/snowman.png" },
      { emoji_id: '4', entity_name: 'umbrella_with_rain', images: "/reaction_images/nature_&_place/umbrella_with_rain.png" },
      { emoji_id: '4', entity_name: 'tornado', images: "/reaction_images/nature_&_place/tornado.png" },
      { emoji_id: '4', entity_name: 'wave', images: "/reaction_images/nature_&_place/wave.png" },
      { emoji_id: '4', entity_name: 'fog', images: "/reaction_images/nature_&_place/fog.png" },
      { emoji_id: '4', entity_name: 'rainbow', images: "/reaction_images/nature_&_place/rainbow.png" },
      { emoji_id: '4', entity_name: 'high_voltage', images: "/reaction_images/nature_&_place/high_voltage.png" },
      { emoji_id: '4', entity_name: 'collision', images: "/reaction_images/nature_&_place/collision.png" },
      { emoji_id: '4', entity_name: 'fire', images: "/reaction_images/nature_&_place/fire.png" },
      { emoji_id: '4', entity_name: 'dashing_away', images: "/reaction_images/nature_&_place/dashing_away.png" },
      { emoji_id: '4', entity_name: 'droplet', images: "/reaction_images/nature_&_place/droplet.png" },
      { emoji_id: '4', entity_name: 'seedling', images: "/reaction_images/nature_&_place/seedling.png" },
      { emoji_id: '4', entity_name: 'sheaf_of_rice', images: "/reaction_images/nature_&_place/sheaf_of_rice.png" },
      { emoji_id: '4', entity_name: 'four_leaf_clover', images: "/reaction_images/nature_&_place/four_leaf_clover.png" },
      { emoji_id: '4', entity_name: 'leaf_fluttering_in_wind', images: "/reaction_images/nature_&_place/leaf_fluttering_in_wind.png" },
      { emoji_id: '4', entity_name: 'fallen_leaf', images: "/reaction_images/nature_&_place/fallen_leaf.png" },
      { emoji_id: '4', entity_name: 'maple_leaf', images: "/reaction_images/nature_&_place/maple_leaf.png" },
      { emoji_id: '4', entity_name: 'bouquet', images: "/reaction_images/nature_&_place/bouquet.png" },
      { emoji_id: '4', entity_name: 'rosette', images: "/reaction_images/nature_&_place/rosette.png" },
      { emoji_id: '4', entity_name: 'tulip', images: "/reaction_images/nature_&_place/tulip.png" },
      { emoji_id: '4', entity_name: 'rose', images: "/reaction_images/nature_&_place/rose.png" },
      { emoji_id: '4', entity_name: 'wilted_flower', images: "/reaction_images/nature_&_place/wilted_flower.png" },
      { emoji_id: '4', entity_name: 'cherry_blossom', images: "/reaction_images/nature_&_place/cherry_blossom.png" },
      { emoji_id: '4', entity_name: 'hibiscus', images: "/reaction_images/nature_&_place/hibiscus.png" },
      { emoji_id: '4', entity_name: 'sunflower', images: "/reaction_images/nature_&_place/sunflower.png" },
      { emoji_id: '4', entity_name: 'blossom', images: "/reaction_images/nature_&_place/blossom.png" },
      { emoji_id: '4', entity_name: 'railway_track', images: "/reaction_images/nature_&_place/railway_track.png" },
      { emoji_id: '4', entity_name: 'motorway', images: "/reaction_images/nature_&_place/motorway.png" },
      { emoji_id: '4', entity_name: 'sunrise', images: "/reaction_images/nature_&_place/sunrise.png" },
      { emoji_id: '4', entity_name: 'sunrise_over_mountains', images: "/reaction_images/nature_&_place/sunrise_over_mountains.png" },
      { emoji_id: '4', entity_name: 'sunset', images: "/reaction_images/nature_&_place/sunset.png" },
      { emoji_id: '4', entity_name: 'cityscape_at_dusk', images: "/reaction_images/nature_&_place/cityscape_at_dusk.png" },
      { emoji_id: '4', entity_name: 'cityscape', images: "/reaction_images/nature_&_place/cityscape.png" },
      { emoji_id: '4', entity_name: 'night_with_stars', images: "/reaction_images/nature_&_place/night_with_stars.png" },
      { emoji_id: '4', entity_name: 'bridge_at_night', images: "/reaction_images/nature_&_place/bridge_at_night.png" },
      { emoji_id: '4', entity_name: 'foggy', images: "/reaction_images/nature_&_place/foggy.png" },
      { emoji_id: '4', entity_name: 'beach_with_umbrella', images: "/reaction_images/nature_&_place/beach_with_umbrella.png" },
      { emoji_id: '4', entity_name: 'desert_island', images: "/reaction_images/nature_&_place/desert_island.png" },
      { emoji_id: '4', entity_name: 'desert', images: "/reaction_images/nature_&_place/desert.png" },
      { emoji_id: '4', entity_name: 'national_park', images: "/reaction_images/nature_&_place/national_park.png" },
      { emoji_id: '4', entity_name: 'moai', images: "/reaction_images/nature_&_place/moai.png" },
      { emoji_id: '4', entity_name: 'statue_of_liberty', images: "/reaction_images/nature_&_place/statue_of_liberty.png" },
      { emoji_id: '4', entity_name: 'tokyo_tower', images: "/reaction_images/nature_&_place/tokyo_tower.png" },
    ]
    
    @reaction_images_activity_and_tradition_and_features = [
      { emoji_id: '5', entity_name: 'kadomatsu', images: "/reaction_images/activity_&_tradition_&_features/kadomatsu.png" },
      { emoji_id: '5', entity_name: 'red_envelope', images: "/reaction_images/activity_&_tradition_&_features/red_envelope.png" },
      { emoji_id: '5', entity_name: 'hinamatsuri', images: "/reaction_images/activity_&_tradition_&_features/hinamatsuri.png" },
      { emoji_id: '5', entity_name: 'koinobori', images: "/reaction_images/activity_&_tradition_&_features/koinobori.png" },
      { emoji_id: '5', entity_name: 'tanabata_tree', images: "/reaction_images/activity_&_tradition_&_features/tanabata_tree.png" },
      { emoji_id: '5', entity_name: 'hurin', images: "/reaction_images/activity_&_tradition_&_features/hurin.png" },
      { emoji_id: '5', entity_name: 'fireworks', images: "/reaction_images/activity_&_tradition_&_features/fireworks.png" },
      { emoji_id: '5', entity_name: 'sparkler', images: "/reaction_images/activity_&_tradition_&_features/sparkler.png" },
      { emoji_id: '5', entity_name: 'otsukimi', images: "/reaction_images/activity_&_tradition_&_features/otsukimi.png" },
      { emoji_id: '5', entity_name: 'jack_o_lantern', images: "/reaction_images/activity_&_tradition_&_features/jack_o_lantern.png" },
      { emoji_id: '5', entity_name: 'christmas_tree', images: "/reaction_images/activity_&_tradition_&_features/christmas_tree.png" },
      { emoji_id: '5', entity_name: 'wrapped_gift', images: "/reaction_images/activity_&_tradition_&_features/wrapped_gift.png" },
      { emoji_id: '5', entity_name: 'party_popper', images: "/reaction_images/activity_&_tradition_&_features/party_popper.png" },
      { emoji_id: '5', entity_name: 'confetti_ball', images: "/reaction_images/activity_&_tradition_&_features/confetti_ball.png" },
      { emoji_id: '5', entity_name: 'hot_beverage', images: "/reaction_images/activity_&_tradition_&_features/hot_beverage.png" },
      { emoji_id: '5', entity_name: 'yunomi', images: "/reaction_images/activity_&_tradition_&_features/yunomi.png" },
      { emoji_id: '5', entity_name: 'beer_mug', images: "/reaction_images/activity_&_tradition_&_features/beer_mug.png" },
      { emoji_id: '5', entity_name: 'clinking_beer_mugs', images: "/reaction_images/activity_&_tradition_&_features/clinking_beer_mugs.png" },
      { emoji_id: '5', entity_name: 'clinking_glasses', images: "/reaction_images/activity_&_tradition_&_features/clinking_glasses.png" },
      { emoji_id: '5', entity_name: 'wine_glass', images: "/reaction_images/activity_&_tradition_&_features/wine_glass.png" },
      { emoji_id: '5', entity_name: 'cocktail_glass', images: "/reaction_images/activity_&_tradition_&_features/cocktail_glass.png" },
      { emoji_id: '5', entity_name: 'champagne', images: "/reaction_images/activity_&_tradition_&_features/champagne.png" },
      { emoji_id: '5', entity_name: 'tokkuri', images: "/reaction_images/activity_&_tradition_&_features/tokkuri.png" },
      { emoji_id: '5', entity_name: 'joker', images: "/reaction_images/activity_&_tradition_&_features/joker.png" },
      { emoji_id: '5', entity_name: 'mahjong_red_dragon', images: "/reaction_images/activity_&_tradition_&_features/mahjong_red_dragon.png" },
      { emoji_id: '5', entity_name: 'hanahuda', images: "/reaction_images/activity_&_tradition_&_features/hanahuda.png" },
    ]
    
    @reaction_images_objects_and_others = [
      { emoji_id: '6', entity_name: 'loudspeaker', images: "/reaction_images/objects_&_others/loudspeaker.png" },
      { emoji_id: '6', entity_name: 'megaphone', images: "/reaction_images/objects_&_others/megaphone.png" },
      { emoji_id: '6', entity_name: 'bell', images: "/reaction_images/objects_&_others/bell.png" },
      { emoji_id: '6', entity_name: 'bell_with_slash', images: "/reaction_images/objects_&_others/bell_with_slash.png" },
      { emoji_id: '6', entity_name: 'musical_notes', images: "/reaction_images/objects_&_others/musical_notes.png" },
      { emoji_id: '6', entity_name: 'microphone', images: "/reaction_images/objects_&_others/microphone.png" },
      { emoji_id: '6', entity_name: 'studio_microphone', images: "/reaction_images/objects_&_others/studio_microphone.png" },
      { emoji_id: '6', entity_name: 'light_bulb', images: "/reaction_images/objects_&_others/light_bulb.png" },
      { emoji_id: '6', entity_name: 'candle', images: "/reaction_images/objects_&_others/candle.png" },
      { emoji_id: '6', entity_name: 'red_paper_lantern', images: "/reaction_images/objects_&_others/red_paper_lantern.png" },
      { emoji_id: '6', entity_name: 'dollar_banknote', images: "/reaction_images/objects_&_others/dollar_banknote.png" },
      { emoji_id: '6', entity_name: 'euro_banknote', images: "/reaction_images/objects_&_others/euro_banknote.png" },
      { emoji_id: '6', entity_name: 'pound_banknote', images: "/reaction_images/objects_&_others/pound_banknote.png" },
      { emoji_id: '6', entity_name: 'yen_banknote', images: "/reaction_images/objects_&_others/yen_banknote.png" },
      { emoji_id: '6', entity_name: 'money_with_wings', images: "/reaction_images/objects_&_others/money_with_wings.png" },
      { emoji_id: '6', entity_name: 'money_bag', images: "/reaction_images/objects_&_others/money_bag.png" },
      { emoji_id: '6', entity_name: 'magnifying_glass', images: "/reaction_images/objects_&_others/magnifying_glass.png" },
      { emoji_id: '6', entity_name: 'memo', images: "/reaction_images/objects_&_others/memo.png" },
      { emoji_id: '6', entity_name: 'hourglass_not_done', images: "/reaction_images/objects_&_others/hourglass_not_done.png" },
      { emoji_id: '6', entity_name: 'roller_coaster', images: "/reaction_images/objects_&_others/roller_coaster.png" },
      { emoji_id: '6', entity_name: 'carousel_horse', images: "/reaction_images/objects_&_others/carousel_horse.png" },
      { emoji_id: '6', entity_name: 'parachute', images: "/reaction_images/objects_&_others/parachute.png" },
      { emoji_id: '6', entity_name: 'water_pistol', images: "/reaction_images/objects_&_others/water_pistol.png" },
      { emoji_id: '6', entity_name: 'teddy_bear', images: "/reaction_images/objects_&_others/teddy_bear.png" },
      { emoji_id: '6', entity_name: 'shopping_cart', images: "/reaction_images/objects_&_others/shopping_cart.png" },
      { emoji_id: '6', entity_name: 'construction', images: "/reaction_images/objects_&_others/construction.png" },
    ]
  
    @reaction_images_symbols = [
      { emoji_id: '7', entity_name: 'check_mark', images: "/reaction_images/symbols/check_mark.png" },
      { emoji_id: '7', entity_name: 'heavy_large_circle', images: "/reaction_images/symbols/heavy_large_circle.png" },
      { emoji_id: '7', entity_name: 'cross_mark', images: "/reaction_images/symbols/cross_mark.png" },
      { emoji_id: '7', entity_name: 'exclamation_mark', images: "/reaction_images/symbols/exclamation_mark.png" },
      { emoji_id: '7', entity_name: 'maruka_button', images: "/reaction_images/symbols/maruka_button.png" },
      { emoji_id: '7', entity_name: 'marutoku_button', images: "/reaction_images/symbols/marutoku_button.png" },
      { emoji_id: '7', entity_name: 'ok_button', images: "/reaction_images/symbols/ok_button.png" },
      { emoji_id: '7', entity_name: 'ng_button', images: "/reaction_images/symbols/ng_button.png" },
      { emoji_id: '7', entity_name: 'beginners_mark', images: "/reaction_images/symbols/beginners_mark.png" }
    ]
  end
  
  def thread_reaction_index
    @gthread = Gthread.find(params[:id])
    @channel = @gthread.channel
  end
  
  def comment_index
    @gthread = Gthread.find(params[:id])
    @comments = @gthread.comments.includes(:user)
    @channel = @gthread.channel
    @comment = Comment.new
  end
  
  def show_additionally
    @channel = Channel.find(params[:channel_id])
    last_id = params[:oldest_gthread_id].to_i - 1
    @gthreads = @channel.gthreads.includes(:user, :thread_reaction_users, :thread_reactions).order(:created_at).where(id: 1..last_id).last(5)
  end
  
  def destroy
    @gthread = Gthread.find_by(user_id: current_user.id, id: params[:id])
    
    if @gthread.destroy
      ActionCable.server.broadcast 'gthread_delete_channel', gthread_id: @gthread['id']
    end
  end
  
  private
    def thread_params
      params.require(:gthread).permit(:user_id, :community_id, :channel_id, :title, :description, { images: [] })#merge(:channel_id)
    end
    
    def is_gthread_author?
      if current_user.id == Gthread.find_by(id: params[:id]).user_id
        true
      else
        redirect_to request.referer, danger: 'あなたにはこのスレッドを削除出来る権限がありません'
      end
    end
end
