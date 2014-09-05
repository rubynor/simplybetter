object @report
attributes :id, :reason, :abuse_reportable_type
child :abuse_reportable do |reportable|
  # The regexp snippet selects everything from the last / and to the end
  extends reportable.to_partial_path.gsub(/\/([^\/]+)$/, '/show')
end
child :abuse_reporter do |reporter|
  extends reporter.to_partial_path.gsub(/\/([^\/]+)$/, '/show')
end
