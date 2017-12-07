# グループ作成
group "nifty" do
  gid 10100
  groupname "nifty"
end

# ユーザ作成
user "cpnifty" do
  uid 10105
  gid "nifty"
  username "cpnifty"
  password "cpnifty"
  shell "/bin/bash"
end

# /home/cpnifty 配下ディレクトリ作成
%w{PLSQL SQL build-resources lib nifty shell tools work share}.each do |dir|
  directory "/home/cpnifty/#{dir}" do
    action :create
    mode "755"
    owner "cpnifty"
    group "nifty"
  end
end

# /home/cpnifty/share 配下ディレクトリ作成
%w{data debug_logs loader logs operation reports source st var}.each do |dir|
  directory "/home/cpnifty/share/#{dir}" do
    action :create
    mode "755"
    owner "cpnifty"
    group "nifty"
  end
end

# /home/cpnifty/share/data 配下ディレクトリ作成
%w{bypass dl oracle receipt/backup receipt/receive receipt/tmp send/backup send/system service/dblog/out tbl work}.each do |dir|
  directory "/home/cpnifty/share/data/#{dir}" do
    action :create
    mode "755"
    owner "cpnifty"
    group "nifty"
  end
end

## receipt/receive receipt/backup共通
%w{adjustapply apply/FLETS apply/family apply/hikari apply/sec24 batch cashback/account_request cashback/account_update cashback/payment changeid copper correction/cancel correction/canceldata correction/present correction/presentcancel correction/tsuketsuke correction/waitdata createmaster/operation createmaster/prior existmkt initialize/carry initialize/cbl initialize/kddi3m initialize/mkt initialize/multi initialize/sec initialize/sec_backup option other present/result/return present/result/send rehearsal rightsfix/bmps/campdata rightsfix/bmps/pointdata tabulation/bbcharge_takeover}.each do |dir|
  directory "/home/cpnifty/share/data/receipt/receive/#{dir}" do
    action :create
    mode "755"
    owner "cpnifty"
    group "nifty"
  end

  directory "/home/cpnifty/share/data/receipt/backup/#{dir}" do
    action :create
    mode "755"
    owner "cpnifty"
    group "nifty"
  end
end

## receipt/receive配下のみ
%w{apply/sec24/loader/bad apply/sec24/loader/control apply/sec24/loader/log present/result/return/wireless_router present/result/send/wireless_router rehearsal/bbcharge_copper rehearsal/charge rehearsal/dump rehearsal/ops_charge rehearsal/ops_user rehearsal/personal rehearsal/tai_tsukekun}.each do |dir|
  directory "/home/cpnifty/share/data/receipt/receive/#{dir}" do
    action :create
    mode "755"
    owner "cpnifty"
    group "nifty"
  end
end

## receipt/backup配下のみ
%w{applyadjust applyplan applyresult route synchronized_apply}.each do |dir|
  directory "/home/cpnifty/share/data/receipt/backup/#{dir}" do
    action :create
    mode "755"
    owner "cpnifty"
    group "nifty"
  end
end

# receipt/tmp 配下
%w{applyplan/archive applyplan/create_work applyplan/import_work applyplan/work contentsdata/create contentsdata/sec createmaster/prior existmkt extpoint initialize/carry initialize/cbl initialize/kddi3m initialize/mkt initialize/multi initialize/sec present/merge present/result/return present/result/send rehearsal synchronized_apply}.each do |dir|
  directory "/home/cpnifty/share/data/receipt/tmp/#{dir}" do
    action :create
    mode "755"
    owner "cpnifty"
    group "nifty"
  end
end

%w{applycs bypass cashback/account_request cashback/account_update cashback/mail/account_complete cashback/mail/account_incomplete cashback/mail/transfer_complete cashback/mail/transfer_incomplete cashback/payment cashback/postcard copper extpoint/bmps/pointdata extpoint/campmaster/merge extpoint/campmaster/pointdata present/koyu present/nifty/entry present/nifty/open rightsfix/bmps/campdata rightsfix/bmps/pointdata rightsfix/campmaster/pointdata rightsfix/commufa rightsfix/mobile rightsfix/nlp tabulation/bbcharge tabulation/bundle tabulation/cppvname tabulation/results}.each do |dir|
  directory "/home/cpnifty/share/data/send/system/#{dir}" do
    action :create
    mode "755"
    owner "cpnifty"
    group "nifty"
  end

  directory "/home/cpnifty/share/data/send/backup/#{dir}" do
    action :create
    mode "755"
    owner "cpnifty"
    group "nifty"
  end
end

%w{bbmatrixTransfer campaignTransfer}.each do |dir|
  directory "/home/cpnifty/share/data/send/backup/#{dir}" do
    action :create
    mode "755"
    owner "cpnifty"
    group "nifty"
  end
end

%w{cash_back2/umps cash_back2/umps_bank mail_send/cashback2/MAIL mail_send/commufa/MAIL mail_send/commufa/in}.each do |dir|
  directory "/home/cpnifty/share/data/service/dblog/out/#{dir}" do
    action :create
    mode "755"
    owner "cpnifty"
    group "nifty"
  end
end

%w{backup/save backup/work}.each do |dir|
  directory "/home/cpnifty/share/data/tbl/#{dir}" do
    action :create
    mode "755"
    owner "cpnifty"
    group "nifty"
  end
end

%w{applyresult/archive applyresult/work}.each do |dir|
  directory "/home/cpnifty/share/data/work/#{dir}" do
    action :create
    mode "755"
    owner "cpnifty"
    group "nifty"
  end
end

# var配下
%w{rightsfix apply spool applyresult correction errormonitor applyplan option work test copper satellite cashback present campaignTransfer bbmatrixTransfer CashbackSummaryReport personalinfo_bmps changeid noneOpsApplyChargedata ApplyCountSumPrimilege validcheck ExecPlsql}.each do |dir|
  directory "/home/cpnifty/share/var/#{dir}" do
    action :create
    mode "755"
    owner "cpnifty"
    group "nifty"
  end
end


directory "/service/camp" do
  action :create
  mode "755"
  owner "cpnifty"
  group "nifty"
end

# /service/camp配下
%w{correct sec24 FLETS hikari FLETLOG contents cable n365 card_p tokuten_togetsu tokuten_taiki bb_tokei_data}.each do |dir|
  directory "/service/camp/#{dir}" do
    action :create
    mode "755"
    owner "cpnifty"
    group "nifty"
  end
end
