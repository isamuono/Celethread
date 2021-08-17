# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )


Rails.application.config.assets.precompile += %w( d_custom.scss )
Rails.application.config.assets.precompile += %w( t_custom.scss )
Rails.application.config.assets.precompile += %w( m_custom.scss )

Rails.application.config.assets.precompile += %w( colorpicker/spectrum.scss )

Rails.application.config.assets.precompile += %w( flatpickr/flatpickr.min.scss )
Rails.application.config.assets.precompile += %w( flatpickr/confirmDate.scss )

Rails.application.config.assets.precompile += %w( cropper/cropper.min.scss )
Rails.application.config.assets.precompile += %w( quill/quill.snow.css )
Rails.application.config.assets.precompile += %w( magnific-popup/magnific-popup.scss )
Rails.application.config.assets.precompile += %w( jquery-toast/jquery.toast.min.css )


Rails.application.config.assets.precompile += %w( cable.js )
Rails.application.config.assets.precompile += %w( pages_index_resize.js )
Rails.application.config.assets.precompile += %w( searches_show_resize.js )
Rails.application.config.assets.precompile += %w( users_new_resize.js )
Rails.application.config.assets.precompile += %w( sessions_new_resize.js )
Rails.application.config.assets.precompile += %w( password_resets_new_resize.js )
Rails.application.config.assets.precompile += %w( password_resets_edit_resize.js )
Rails.application.config.assets.precompile += %w( communities_new_resize.js )
Rails.application.config.assets.precompile += %w( invitations_new_resize.js )
Rails.application.config.assets.precompile += %w( channels_new_resize.js )
Rails.application.config.assets.precompile += %w( gthreads_index.js )
Rails.application.config.assets.precompile += %w( events_new_resize.js )

Rails.application.config.assets.precompile += %w( bootstrap-add-clear/bootstrap-add-clear.min.js )
Rails.application.config.assets.precompile += %w( colorpicker/spectrum.js )

Rails.application.config.assets.precompile += %w( flatpickr/flatpickr.min.js )
Rails.application.config.assets.precompile += %w( flatpickr/ja.js )
Rails.application.config.assets.precompile += %w( flatpickr/rangePlugin.js )
Rails.application.config.assets.precompile += %w( flatpickr/confirmDate.js )
Rails.application.config.assets.precompile += %w( timepicker/datepair.min.js )

Rails.application.config.assets.precompile += %w( fullcalendar/main.min.js )
Rails.application.config.assets.precompile += %w( fullcalendar/ja.js )

Rails.application.config.assets.precompile += %w( tippy/tippy.umd.min.js )
Rails.application.config.assets.precompile += %w( readmore-js/readmore.min.js )
Rails.application.config.assets.precompile += %w( quill/quill.js )
Rails.application.config.assets.precompile += %w( pdf.js/pdf.min.js )
Rails.application.config.assets.precompile += %w( pdf.js/pdf.worker.min.js )
Rails.application.config.assets.precompile += %w( magnific-popup/jquery.magnific-popup.min.js )
Rails.application.config.assets.precompile += %w( jquery-toast/jquery.toast.min.js )


Rails.application.config.assets.precompile += %w( cropper/cropper.min.js )
Rails.application.config.assets.precompile += %w( cropper/jquery-cropper.min.js )
Rails.application.config.assets.precompile += %w( crop_image.js )
