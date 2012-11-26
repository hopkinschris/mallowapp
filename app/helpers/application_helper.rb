module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  # Can return four different sizes from Twitter API
  # :original - size is undefined, whatever user uploaded
  # :mini - 24px by 24px
  # :normal - 48px by 48px
  # :bigger - 73px by 73px
  def mailer_unfollower_details(size, id, options={})
    if options[:style]
      style = options[:style]
    end
    src = Twitter.user(id).profile_image_url(size)
    name = Twitter.user(id).name
    handle = '@' + Twitter.user(id).screen_name
    details = 
      content_tag(:li, name, :class => 'name', :style => "list-style:none;font-weight:500;color:#444;") +
      content_tag(:li, handle, :class => 'handle', :style => "list-style:none;color:#999;font-weight:300;")
    content_tag(:img, nil, :src => src, :class => 'avatar', :style => style) +
    content_tag(:ul, details, :style => "padding:0;margin:0;float:right;")
  end

  def mailer_unfollower_link(id, options={})
    link_to mailer_unfollower_details(:normal, id, options), "http://twitter.com/#{Twitter.user(id).screen_name}", :target => '_blank', :style => "display:inline-block;text-decoration:none;"
  end

  # Can return four different sizes from Twitter API
  # :original - size is undefined, whatever user uploaded
  # :mini - 24px by 24px
  # :normal - 48px by 48px
  # :bigger - 73px by 73px
  def unfollower_details(size, id)
    src = Twitter.user(id).profile_image_url(size)
    name = Twitter.user(id).name
    handle = '@' + Twitter.user(id).screen_name
    content_tag(:img, nil, :src => src, :class => 'avatar') +
    content_tag(:li, name, :class => 'name') +
    content_tag(:li, handle, :class => 'handle')
  end

  def unfollower_link(id)
    link_to unfollower_details(:normal, id), "http://twitter.com/#{Twitter.user(id).screen_name}", :target => '_blank'
  end

end
