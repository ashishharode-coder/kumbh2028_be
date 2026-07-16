Rails.application.config.active_storage.previewers = [
  ActiveStorage::Previewer::VideoPreviewer,
  ActiveStorage::Previewer::PopplerPDFPreviewer,
  ActiveStorage::Previewer::MuPDFPreviewer
]