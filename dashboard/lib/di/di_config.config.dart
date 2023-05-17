// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:c4d/hive/util/argument_hive_helper.dart' as _i3;
import 'package:c4d/main.dart' as _i270;
import 'package:c4d/module_auth/authoriazation_module.dart' as _i137;
import 'package:c4d/module_auth/manager/auth_manager/auth_manager.dart' as _i24;
import 'package:c4d/module_auth/presistance/auth_prefs_helper.dart' as _i4;
import 'package:c4d/module_auth/repository/auth/auth_repository.dart' as _i21;
import 'package:c4d/module_auth/service/auth_service/auth_service.dart' as _i25;
import 'package:c4d/module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i35;
import 'package:c4d/module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i38;
import 'package:c4d/module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i47;
import 'package:c4d/module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i80;
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart'
    as _i85;
import 'package:c4d/module_auth/ui/screen/register_screen/register_screen.dart'
    as _i113;
import 'package:c4d/module_bid_order/bid_order_module.dart' as _i139;
import 'package:c4d/module_bid_order/manager/bid_order_manager.dart' as _i58;
import 'package:c4d/module_bid_order/repository/bid_order_repository.dart'
    as _i26;
import 'package:c4d/module_bid_order/service/bid_order_service.dart' as _i59;
import 'package:c4d/module_bid_order/state_manager/bid_order_state_manager.dart'
    as _i60;
import 'package:c4d/module_bid_order/ui/screen/bid_orders_screen.dart' as _i61;
import 'package:c4d/module_bid_order/ui/screen/order_details_screen.dart'
    as _i138;
import 'package:c4d/module_branches/branches_module.dart' as _i264;
import 'package:c4d/module_branches/manager/branches_manager.dart' as _i62;
import 'package:c4d/module_branches/repository/branches_repository.dart'
    as _i27;
import 'package:c4d/module_branches/service/branches_list_service.dart'
    as _i140;
import 'package:c4d/module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i141;
import 'package:c4d/module_branches/state_manager/init_branches_state_manager.dart'
    as _i171;
import 'package:c4d/module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i214;
import 'package:c4d/module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i217;
import 'package:c4d/module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i240;
import 'package:c4d/module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i263;
import 'package:c4d/module_captain/captains_module.dart' as _i265;
import 'package:c4d/module_captain/hive/captain_hive_helper.dart' as _i5;
import 'package:c4d/module_captain/manager/captains_manager.dart' as _i63;
import 'package:c4d/module_captain/repository/captains_repository.dart' as _i28;
import 'package:c4d/module_captain/service/captains_service.dart' as _i64;
import 'package:c4d/module_captain/state_manager/captain_account_balance_state_manager.dart'
    as _i136;
import 'package:c4d/module_captain/state_manager/captain_activity_details_state_manager.dart'
    as _i143;
import 'package:c4d/module_captain/state_manager/captain_activity_state_manager.dart'
    as _i154;
import 'package:c4d/module_captain/state_manager/captain_finance_daily_state_manager.dart'
    as _i148;
import 'package:c4d/module_captain/state_manager/captain_financial_dues_details_state_manager.dart'
    as _i149;
import 'package:c4d/module_captain/state_manager/captain_financial_dues_state_manager.dart'
    as _i150;
import 'package:c4d/module_captain/state_manager/captain_list.dart' as _i65;
import 'package:c4d/module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i155;
import 'package:c4d/module_captain/state_manager/captain_offer_state_manager.dart'
    as _i151;
import 'package:c4d/module_captain/state_manager/captain_order_assign_state_manager.dart'
    as _i144;
import 'package:c4d/module_captain/state_manager/captain_profile_state_manager.dart'
    as _i153;
import 'package:c4d/module_captain/state_manager/captain_rating_state_manager.dart'
    as _i156;
import 'package:c4d/module_captain/state_manager/captin_rating_details_state_manager.dart'
    as _i66;
import 'package:c4d/module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i84;
import 'package:c4d/module_captain/state_manager/plan_screen_state_manager.dart'
    as _i111;
import 'package:c4d/module_captain/ui/screen/captain_account_balance_screen.dart'
    as _i142;
import 'package:c4d/module_captain/ui/screen/captain_activity_details_screen.dart'
    as _i218;
import 'package:c4d/module_captain/ui/screen/captain_activity_model.dart'
    as _i227;
import 'package:c4d/module_captain/ui/screen/captain_finance_daily_screen.dart'
    as _i223;
import 'package:c4d/module_captain/ui/screen/captain_financial_details_screen.dart'
    as _i224;
import 'package:c4d/module_captain/ui/screen/captain_financial_dues_screen.dart'
    as _i225;
import 'package:c4d/module_captain/ui/screen/captain_needs_support_screen.dart'
    as _i228;
import 'package:c4d/module_captain/ui/screen/captain_profile_screen.dart'
    as _i226;
import 'package:c4d/module_captain/ui/screen/captain_rating_screen.dart'
    as _i229;
import 'package:c4d/module_captain/ui/screen/captains_assign_order_screen.dart'
    as _i219;
import 'package:c4d/module_captain/ui/screen/captains_list_screen.dart'
    as _i157;
import 'package:c4d/module_captain/ui/screen/captains_offer_screen.dart'
    as _i152;
import 'package:c4d/module_captain/ui/screen/captin_rating_details_state.dart'
    as _i158;
import 'package:c4d/module_captain/ui/screen/change_captain_plan_screen.dart'
    as _i192;
import 'package:c4d/module_captain/ui/screen/in_active_captains_screen.dart'
    as _i169;
import 'package:c4d/module_categories/categories_module.dart' as _i231;
import 'package:c4d/module_categories/manager/categories_manager.dart' as _i70;
import 'package:c4d/module_categories/repository/categories_repository.dart'
    as _i30;
import 'package:c4d/module_categories/service/store_categories_service.dart'
    as _i71;
import 'package:c4d/module_categories/state_manager/categories_state_manager.dart'
    as _i106;
import 'package:c4d/module_categories/state_manager/packages_state_manager.dart'
    as _i107;
import 'package:c4d/module_categories/ui/screen/categories_screen.dart'
    as _i160;
import 'package:c4d/module_categories/ui/screen/packages_screen.dart' as _i190;
import 'package:c4d/module_chat/chat_module.dart' as _i232;
import 'package:c4d/module_chat/manager/chat/chat_manager.dart' as _i72;
import 'package:c4d/module_chat/presistance/chat_hive_helper.dart' as _i6;
import 'package:c4d/module_chat/repository/chat/chat_repository.dart' as _i31;
import 'package:c4d/module_chat/service/chat/char_service.dart' as _i73;
import 'package:c4d/module_chat/state_manager/chat_state_manager.dart' as _i74;
import 'package:c4d/module_chat/ui/screens/chat_page/chat_page.dart' as _i161;
import 'package:c4d/module_company/company_module.dart' as _i266;
import 'package:c4d/module_company/manager/company_manager.dart' as _i75;
import 'package:c4d/module_company/repository/company_repository.dart' as _i32;
import 'package:c4d/module_company/service/company_service.dart' as _i76;
import 'package:c4d/module_company/state_manager/company_financial_state_manager.dart'
    as _i162;
import 'package:c4d/module_company/state_manager/company_profile_state_manager.dart'
    as _i163;
import 'package:c4d/module_company/ui/screen/company_finance_screen.dart'
    as _i233;
import 'package:c4d/module_company/ui/screen/company_profile_screen.dart'
    as _i234;
import 'package:c4d/module_deep_links/repository/deep_link_repository.dart'
    as _i33;
import 'package:c4d/module_delivary_car/cars_module.dart' as _i230;
import 'package:c4d/module_delivary_car/manager/cars_manager.dart' as _i67;
import 'package:c4d/module_delivary_car/repository/cars_repository.dart'
    as _i29;
import 'package:c4d/module_delivary_car/service/cars_service.dart' as _i68;
import 'package:c4d/module_delivary_car/state_manager/cars_state_manager.dart'
    as _i69;
import 'package:c4d/module_delivary_car/ui/screen/cars_screen.dart' as _i159;
import 'package:c4d/module_dev/dev_module.dart' as _i237;
import 'package:c4d/module_dev/hive/order_hive_helper.dart' as _i15;
import 'package:c4d/module_dev/manager/dev_manager.dart' as _i77;
import 'package:c4d/module_dev/repository/dev_repository.dart' as _i34;
import 'package:c4d/module_dev/service/orders/dev.service.dart' as _i78;
import 'package:c4d/module_dev/state_manager/new_order/new_test_order_state_manager.dart'
    as _i91;
import 'package:c4d/module_dev/ui/screens/new_test_order/new_test_order_screen.dart'
    as _i176;
import 'package:c4d/module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i10;
import 'package:c4d/module_localization/service/localization_service/localization_service.dart'
    as _i11;
import 'package:c4d/module_main/main_module.dart' as _i267;
import 'package:c4d/module_main/manager/home_manager.dart' as _i81;
import 'package:c4d/module_main/repository/home_repository.dart' as _i36;
import 'package:c4d/module_main/sceen/home_screen.dart' as _i168;
import 'package:c4d/module_main/sceen/main_screen.dart' as _i241;
import 'package:c4d/module_main/service/home_service.dart' as _i82;
import 'package:c4d/module_main/state_manager/home_state_manager.dart' as _i83;
import 'package:c4d/module_my_notifications/manager/my_notifications_manager.dart'
    as _i86;
import 'package:c4d/module_my_notifications/my_notifications_module.dart'
    as _i242;
import 'package:c4d/module_my_notifications/repository/my_notifications_repository.dart'
    as _i39;
import 'package:c4d/module_my_notifications/service/my_notification_service.dart'
    as _i87;
import 'package:c4d/module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i88;
import 'package:c4d/module_my_notifications/state_manager/update_state_manager.dart'
    as _i135;
import 'package:c4d/module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i173;
import 'package:c4d/module_my_notifications/ui/screen/update_screen.dart'
    as _i215;
import 'package:c4d/module_network/http_client/http_client.dart' as _i19;
import 'package:c4d/module_notice/manager/notice_manager.dart' as _i92;
import 'package:c4d/module_notice/notice_module.dart' as _i243;
import 'package:c4d/module_notice/repository/notice_repository.dart' as _i40;
import 'package:c4d/module_notice/service/notice_service.dart' as _i93;
import 'package:c4d/module_notice/state_manager/notice_state_manager.dart'
    as _i94;
import 'package:c4d/module_notice/ui/screen/notice_screen.dart' as _i177;
import 'package:c4d/module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i13;
import 'package:c4d/module_notifications/repository/notification_repo.dart'
    as _i41;
import 'package:c4d/module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i79;
import 'package:c4d/module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i9;
import 'package:c4d/module_orders/hive/order_hive_helper.dart' as _i14;
import 'package:c4d/module_orders/manager/orders_manager/orders_manager.dart'
    as _i43;
import 'package:c4d/module_orders/orders_module.dart' as _i248;
import 'package:c4d/module_orders/repository/order_repository/order_repository.dart'
    as _i42;
import 'package:c4d/module_orders/service/orders/orders.service.dart' as _i44;
import 'package:c4d/module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i90;
import 'package:c4d/module_orders/state_manager/new_order/new_order_link_state_manager.dart'
    as _i89;
import 'package:c4d/module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i57;
import 'package:c4d/module_orders/state_manager/order_action_logs_state_manager.dart'
    as _i95;
import 'package:c4d/module_orders/state_manager/order_captain_logs_state_manager.dart'
    as _i96;
import 'package:c4d/module_orders/state_manager/order_cash_captain_state_manager.dart'
    as _i97;
import 'package:c4d/module_orders/state_manager/order_cash_store_state_manager.dart'
    as _i103;
import 'package:c4d/module_orders/state_manager/order_distance_conflict_state_manager.dart'
    as _i98;
import 'package:c4d/module_orders/state_manager/order_logs_state_manager.dart'
    as _i99;
import 'package:c4d/module_orders/state_manager/order_pending_state_manager.dart'
    as _i100;
import 'package:c4d/module_orders/state_manager/orders_recieve_cash_state_manager.dart'
    as _i104;
import 'package:c4d/module_orders/state_manager/orders_without_distance_state_manager.dart'
    as _i101;
import 'package:c4d/module_orders/state_manager/recycle_order/recycle_order_state_manager.dart'
    as _i46;
import 'package:c4d/module_orders/state_manager/search_for_order_state_manager.dart'
    as _i48;
import 'package:c4d/module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i52;
import 'package:c4d/module_orders/ui/screens/new_order/new_order_link.dart'
    as _i174;
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart'
    as _i175;
import 'package:c4d/module_orders/ui/screens/new_order/update_order_screen.dart'
    as _i134;
import 'package:c4d/module_orders/ui/screens/order_actions_log_screen.dart'
    as _i178;
import 'package:c4d/module_orders/ui/screens/order_cash_captain_screen.dart'
    as _i102;
import 'package:c4d/module_orders/ui/screens/order_cash_store_screen.dart'
    as _i187;
import 'package:c4d/module_orders/ui/screens/order_conflict_distance_screen.dart'
    as _i181;
import 'package:c4d/module_orders/ui/screens/order_logs_screen.dart' as _i182;
import 'package:c4d/module_orders/ui/screens/order_pending_screen.dart'
    as _i184;
import 'package:c4d/module_orders/ui/screens/orders_captain_screen.dart'
    as _i179;
import 'package:c4d/module_orders/ui/screens/orders_receive_cash_screen.dart'
    as _i188;
import 'package:c4d/module_orders/ui/screens/orders_without_distance_screen.dart'
    as _i105;
import 'package:c4d/module_orders/ui/screens/recycle_order/recycle_order_screen.dart'
    as _i112;
import 'package:c4d/module_orders/ui/screens/search_for_order_screen.dart'
    as _i114;
import 'package:c4d/module_orders/ui/screens/sub_orders_screen.dart' as _i124;
import 'package:c4d/module_payments/manager/payments_manager.dart' as _i108;
import 'package:c4d/module_payments/payments_module.dart' as _i249;
import 'package:c4d/module_payments/repository/payments_repository.dart'
    as _i45;
import 'package:c4d/module_payments/service/payments_service.dart' as _i109;
import 'package:c4d/module_payments/state_manager/captain_daily_finance_state_manager.dart'
    as _i164;
import 'package:c4d/module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i145;
import 'package:c4d/module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i146;
import 'package:c4d/module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i147;
import 'package:c4d/module_payments/state_manager/payments_to_state_manager.dart'
    as _i110;
import 'package:c4d/module_payments/state_manager/store_balance_state_manager.dart'
    as _i120;
import 'package:c4d/module_payments/ui/screen/all_amount_captains_screen.dart'
    as _i216;
import 'package:c4d/module_payments/ui/screen/captain_finance_by_hours_screen.dart'
    as _i221;
import 'package:c4d/module_payments/ui/screen/captain_finance_by_order_count_screen.dart'
    as _i220;
import 'package:c4d/module_payments/ui/screen/captain_finance_by_order_screen.dart'
    as _i222;
import 'package:c4d/module_payments/ui/screen/daily_payments_screen.dart'
    as _i165;
import 'package:c4d/module_payments/ui/screen/payment_to_captain_screen.dart'
    as _i191;
import 'package:c4d/module_payments/ui/screen/store_balance_screen.dart'
    as _i195;
import 'package:c4d/module_settings/settings_module.dart' as _i193;
import 'package:c4d/module_settings/ui/settings_page/choose_local_page.dart'
    as _i22;
import 'package:c4d/module_settings/ui/settings_page/settings_page.dart'
    as _i115;
import 'package:c4d/module_splash/splash_module.dart' as _i116;
import 'package:c4d/module_splash/ui/screen/splash_screen.dart' as _i49;
import 'package:c4d/module_statistics/manager/statistic_manager.dart' as _i117;
import 'package:c4d/module_statistics/repository/statistics_repository.dart'
    as _i50;
import 'package:c4d/module_statistics/service/statistics_service.dart' as _i118;
import 'package:c4d/module_statistics/state_manager/statistics_state_manager.dart'
    as _i119;
import 'package:c4d/module_statistics/ui/screen/statistics_screen.dart'
    as _i194;
import 'package:c4d/module_statistics/ui/statistics_module.dart' as _i250;
import 'package:c4d/module_stores/hive/store_hive_helper.dart' as _i16;
import 'package:c4d/module_stores/manager/stores_manager.dart' as _i121;
import 'package:c4d/module_stores/repository/stores_repository.dart' as _i51;
import 'package:c4d/module_stores/service/store_service.dart' as _i122;
import 'package:c4d/module_stores/state_manager/order/filter_orders_top_active_state_manager.dart'
    as _i167;
import 'package:c4d/module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i180;
import 'package:c4d/module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i183;
import 'package:c4d/module_stores/state_manager/order/order_status.state_manager.dart'
    as _i185;
import 'package:c4d/module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i186;
import 'package:c4d/module_stores/state_manager/store_dues_state_manager.dart'
    as _i196;
import 'package:c4d/module_stores/state_manager/store_profile_state_manager.dart'
    as _i198;
import 'package:c4d/module_stores/state_manager/stores_dues_state_manager.dart'
    as _i203;
import 'package:c4d/module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i204;
import 'package:c4d/module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i205;
import 'package:c4d/module_stores/state_manager/stores_state_manager.dart'
    as _i123;
import 'package:c4d/module_stores/state_manager/top_active_store.dart' as _i132;
import 'package:c4d/module_stores/stores_module.dart' as _i268;
import 'package:c4d/module_stores/ui/screen/order/order_captain_not_arrived.dart'
    as _i244;
import 'package:c4d/module_stores/ui/screen/order/order_details_screen.dart'
    as _i245;
import 'package:c4d/module_stores/ui/screen/order/order_logs_screen.dart'
    as _i246;
import 'package:c4d/module_stores/ui/screen/order/order_time_line_screen.dart'
    as _i247;
import 'package:c4d/module_stores/ui/screen/order/order_top_active_store.dart'
    as _i189;
import 'package:c4d/module_stores/ui/screen/store_info_screen.dart' as _i252;
import 'package:c4d/module_stores/ui/screen/stores_dues/store_dues_screen.dart'
    as _i251;
import 'package:c4d/module_stores/ui/screen/stores_dues/stores_dues_screen.dart'
    as _i255;
import 'package:c4d/module_stores/ui/screen/stores_inactive_screen.dart'
    as _i256;
import 'package:c4d/module_stores/ui/screen/stores_needs_support_screen.dart'
    as _i257;
import 'package:c4d/module_stores/ui/screen/stores_screen.dart' as _i206;
import 'package:c4d/module_stores/ui/screen/top_active_store_screen.dart'
    as _i133;
import 'package:c4d/module_subscriptions/manager/subscriptions_manager.dart'
    as _i125;
import 'package:c4d/module_subscriptions/repository/subscriptions_repository.dart'
    as _i53;
import 'package:c4d/module_subscriptions/service/subscriptions_service.dart'
    as _i126;
import 'package:c4d/module_subscriptions/state_manager/edit_subscription_state_manager.dart'
    as _i166;
import 'package:c4d/module_subscriptions/state_manager/init_subscription_state_manager.dart'
    as _i172;
import 'package:c4d/module_subscriptions/state_manager/store_financial_subscriptions_details_state_manager.dart'
    as _i197;
import 'package:c4d/module_subscriptions/state_manager/store_subscription_management_state_manager.dart'
    as _i199;
import 'package:c4d/module_subscriptions/state_manager/store_subscriptions_expired_finance_state_manager.dart'
    as _i200;
import 'package:c4d/module_subscriptions/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i202;
import 'package:c4d/module_subscriptions/state_manager/subscription_to_captain_offer_state_manager.dart'
    as _i208;
import 'package:c4d/module_subscriptions/subscriptions_module.dart' as _i258;
import 'package:c4d/module_subscriptions/ui/screen/edit_subscription_screen.dart'
    as _i238;
import 'package:c4d/module_subscriptions/ui/screen/init_subscription_screen.dart'
    as _i235;
import 'package:c4d/module_subscriptions/ui/screen/store_subscriptions_details_screen.dart'
    as _i201;
import 'package:c4d/module_subscriptions/ui/screen/store_subscriptions_expired_screen.dart'
    as _i253;
import 'package:c4d/module_subscriptions/ui/screen/store_subscriptions_screen.dart'
    as _i254;
import 'package:c4d/module_subscriptions/ui/screen/subscription_to_captain_offer_screen.dart'
    as _i236;
import 'package:c4d/module_subscriptions/ui/screen/subscriptions_managment_screen.dart'
    as _i207;
import 'package:c4d/module_supplier/manager/supplier_manager.dart' as _i56;
import 'package:c4d/module_supplier/repository/supplier_repository.dart'
    as _i55;
import 'package:c4d/module_supplier/service/supplier_service.dart' as _i130;
import 'package:c4d/module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i170;
import 'package:c4d/module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i209;
import 'package:c4d/module_supplier/state_manager/supplier_list.dart' as _i131;
import 'package:c4d/module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i211;
import 'package:c4d/module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i212;
import 'package:c4d/module_supplier/supplier_module.dart' as _i269;
import 'package:c4d/module_supplier/ui/screen/in_active_supplier_screen.dart'
    as _i239;
import 'package:c4d/module_supplier/ui/screen/supplier_ads_screen.dart'
    as _i259;
import 'package:c4d/module_supplier/ui/screen/supplier_list_screen.dart'
    as _i213;
import 'package:c4d/module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i261;
import 'package:c4d/module_supplier/ui/screen/supplier_profile_screen.dart'
    as _i262;
import 'package:c4d/module_supplier_categories/categories_supplier_module.dart'
    as _i260;
import 'package:c4d/module_supplier_categories/manager/categories_manager.dart'
    as _i127;
import 'package:c4d/module_supplier_categories/repository/categories_repository.dart'
    as _i54;
import 'package:c4d/module_supplier_categories/service/supplier_categories_service.dart'
    as _i128;
import 'package:c4d/module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i129;
import 'package:c4d/module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i210;
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart'
    as _i17;
import 'package:c4d/module_theme/service/theme_service/theme_service.dart'
    as _i20;
import 'package:c4d/module_upload/manager/upload_manager/upload_manager.dart'
    as _i23;
import 'package:c4d/module_upload/repository/upload_repository/upload_repository.dart'
    as _i18;
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart'
    as _i37;
import 'package:c4d/utils/global/global_state_manager.dart' as _i8;
import 'package:c4d/utils/helpers/firestore_helper.dart' as _i7;
import 'package:c4d/utils/logger/logger.dart' as _i12;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt getIt,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i3.ArgumentHiveHelper>(() => _i3.ArgumentHiveHelper());
  gh.factory<_i4.AuthPrefsHelper>(() => _i4.AuthPrefsHelper());
  gh.factory<_i5.CaptainsHiveHelper>(() => _i5.CaptainsHiveHelper());
  gh.factory<_i6.ChatHiveHelper>(() => _i6.ChatHiveHelper());
  gh.factory<_i7.FireStoreHelper>(() => _i7.FireStoreHelper());
  gh.singleton<_i8.GlobalStateManager>(_i8.GlobalStateManager());
  gh.factory<_i9.LocalNotificationService>(
      () => _i9.LocalNotificationService());
  gh.factory<_i10.LocalizationPreferencesHelper>(
      () => _i10.LocalizationPreferencesHelper());
  gh.factory<_i11.LocalizationService>(
      () => _i11.LocalizationService(gh<_i10.LocalizationPreferencesHelper>()));
  gh.factory<_i12.Logger>(() => _i12.Logger());
  gh.factory<_i13.NotificationsPrefHelper>(
      () => _i13.NotificationsPrefHelper());
  gh.factory<_i14.OrderHiveHelper>(() => _i14.OrderHiveHelper());
  gh.factory<_i15.OrderHiveHelper>(() => _i15.OrderHiveHelper());
  gh.factory<_i16.StoresHiveHelper>(() => _i16.StoresHiveHelper());
  gh.factory<_i17.ThemePreferencesHelper>(() => _i17.ThemePreferencesHelper());
  gh.factory<_i18.UploadRepository>(() => _i18.UploadRepository());
  gh.factory<_i19.ApiClient>(() => _i19.ApiClient(gh<_i12.Logger>()));
  gh.factory<_i20.AppThemeDataService>(
      () => _i20.AppThemeDataService(gh<_i17.ThemePreferencesHelper>()));
  gh.factory<_i21.AuthRepository>(
      () => _i21.AuthRepository(gh<_i19.ApiClient>(), gh<_i12.Logger>()));
  gh.factory<_i22.ChooseLocalScreen>(
      () => _i22.ChooseLocalScreen(gh<_i11.LocalizationService>()));
  gh.factory<_i23.UploadManager>(
      () => _i23.UploadManager(gh<_i18.UploadRepository>()));
  gh.factory<_i24.AuthManager>(
      () => _i24.AuthManager(gh<_i21.AuthRepository>()));
  gh.factory<_i25.AuthService>(() =>
      _i25.AuthService(gh<_i4.AuthPrefsHelper>(), gh<_i24.AuthManager>()));
  gh.factory<_i26.BidOrderRepository>(() =>
      _i26.BidOrderRepository(gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i27.BranchesRepository>(() =>
      _i27.BranchesRepository(gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i28.CaptainsRepository>(() =>
      _i28.CaptainsRepository(gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i29.CarsRepository>(
      () => _i29.CarsRepository(gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i30.CategoriesRepository>(() =>
      _i30.CategoriesRepository(gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i31.ChatRepository>(
      () => _i31.ChatRepository(gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i32.CompanyRepository>(() =>
      _i32.CompanyRepository(gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i33.DeepLinkRepository>(() =>
      _i33.DeepLinkRepository(gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i34.DevRepository>(
      () => _i34.DevRepository(gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i35.ForgotPassStateManager>(
      () => _i35.ForgotPassStateManager(gh<_i25.AuthService>()));
  gh.factory<_i36.HomeRepository>(
      () => _i36.HomeRepository(gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i37.ImageUploadService>(
      () => _i37.ImageUploadService(gh<_i23.UploadManager>()));
  gh.factory<_i38.LoginStateManager>(
      () => _i38.LoginStateManager(gh<_i25.AuthService>()));
  gh.factory<_i39.MyNotificationsRepository>(() =>
      _i39.MyNotificationsRepository(
          gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i40.NoticeRepository>(() =>
      _i40.NoticeRepository(gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i41.NotificationRepo>(() =>
      _i41.NotificationRepo(gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i42.OrderRepository>(
      () => _i42.OrderRepository(gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i43.OrdersManager>(
      () => _i43.OrdersManager(gh<_i42.OrderRepository>()));
  gh.factory<_i44.OrdersService>(
      () => _i44.OrdersService(gh<_i43.OrdersManager>()));
  gh.factory<_i45.PaymentsRepository>(() =>
      _i45.PaymentsRepository(gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i46.RecycleOrderStateManager>(
      () => _i46.RecycleOrderStateManager(gh<_i44.OrdersService>()));
  gh.factory<_i47.RegisterStateManager>(
      () => _i47.RegisterStateManager(gh<_i25.AuthService>()));
  gh.factory<_i48.SearchForOrderStateManager>(
      () => _i48.SearchForOrderStateManager(gh<_i44.OrdersService>()));
  gh.factory<_i49.SplashScreen>(
      () => _i49.SplashScreen(gh<_i25.AuthService>()));
  gh.factory<_i50.StatisticsRepository>(() =>
      _i50.StatisticsRepository(gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i51.StoresRepository>(() =>
      _i51.StoresRepository(gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i52.SubOrdersStateManager>(() => _i52.SubOrdersStateManager(
      gh<_i44.OrdersService>(), gh<_i25.AuthService>()));
  gh.factory<_i53.SubscriptionsRepository>(() => _i53.SubscriptionsRepository(
      gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i54.SupplierCategoriesRepository>(() =>
      _i54.SupplierCategoriesRepository(
          gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i55.SupplierRepository>(() =>
      _i55.SupplierRepository(gh<_i19.ApiClient>(), gh<_i25.AuthService>()));
  gh.factory<_i56.SuppliersManager>(
      () => _i56.SuppliersManager(gh<_i55.SupplierRepository>()));
  gh.factory<_i57.UpdateOrderStateManager>(
      () => _i57.UpdateOrderStateManager(gh<_i44.OrdersService>()));
  gh.factory<_i58.BidOrderManager>(
      () => _i58.BidOrderManager(gh<_i26.BidOrderRepository>()));
  gh.factory<_i59.BidOrderService>(
      () => _i59.BidOrderService(gh<_i58.BidOrderManager>()));
  gh.factory<_i60.BidOrderStateManager>(
      () => _i60.BidOrderStateManager(gh<_i59.BidOrderService>()));
  gh.factory<_i61.BidOrdersScreen>(
      () => _i61.BidOrdersScreen(gh<_i60.BidOrderStateManager>()));
  gh.factory<_i62.BranchesManager>(
      () => _i62.BranchesManager(gh<_i27.BranchesRepository>()));
  gh.factory<_i63.CaptainsManager>(
      () => _i63.CaptainsManager(gh<_i28.CaptainsRepository>()));
  gh.factory<_i64.CaptainsService>(
      () => _i64.CaptainsService(gh<_i63.CaptainsManager>()));
  gh.factory<_i65.CaptainsStateManager>(
      () => _i65.CaptainsStateManager(gh<_i64.CaptainsService>()));
  gh.factory<_i66.CaptinRatingDetailsStateManager>(
      () => _i66.CaptinRatingDetailsStateManager(gh<_i64.CaptainsService>()));
  gh.factory<_i67.CarsManager>(
      () => _i67.CarsManager(gh<_i29.CarsRepository>()));
  gh.factory<_i68.CarsService>(() => _i68.CarsService(gh<_i67.CarsManager>()));
  gh.factory<_i69.CarsStateManager>(
      () => _i69.CarsStateManager(gh<_i68.CarsService>()));
  gh.factory<_i70.CategoriesManager>(
      () => _i70.CategoriesManager(gh<_i30.CategoriesRepository>()));
  gh.factory<_i71.CategoriesService>(
      () => _i71.CategoriesService(gh<_i70.CategoriesManager>()));
  gh.factory<_i72.ChatManager>(
      () => _i72.ChatManager(gh<_i31.ChatRepository>()));
  gh.factory<_i73.ChatService>(() => _i73.ChatService(gh<_i72.ChatManager>()));
  gh.factory<_i74.ChatStateManager>(
      () => _i74.ChatStateManager(gh<_i73.ChatService>()));
  gh.factory<_i75.CompanyManager>(
      () => _i75.CompanyManager(gh<_i32.CompanyRepository>()));
  gh.factory<_i76.CompanyService>(
      () => _i76.CompanyService(gh<_i75.CompanyManager>()));
  gh.factory<_i77.DevManager>(() => _i77.DevManager(gh<_i34.DevRepository>()));
  gh.factory<_i78.DevService>(() => _i78.DevService(gh<_i77.DevManager>()));
  gh.factory<_i79.FireNotificationService>(() => _i79.FireNotificationService(
      gh<_i13.NotificationsPrefHelper>(), gh<_i41.NotificationRepo>()));
  gh.factory<_i80.ForgotPassScreen>(
      () => _i80.ForgotPassScreen(gh<_i35.ForgotPassStateManager>()));
  gh.factory<_i81.HomeManager>(
      () => _i81.HomeManager(gh<_i36.HomeRepository>()));
  gh.factory<_i82.HomeService>(() => _i82.HomeService(gh<_i81.HomeManager>()));
  gh.factory<_i83.HomeStateManager>(
      () => _i83.HomeStateManager(gh<_i82.HomeService>()));
  gh.factory<_i84.InActiveCaptainsStateManager>(
      () => _i84.InActiveCaptainsStateManager(gh<_i64.CaptainsService>()));
  gh.factory<_i85.LoginScreen>(
      () => _i85.LoginScreen(gh<_i38.LoginStateManager>()));
  gh.factory<_i86.MyNotificationsManager>(
      () => _i86.MyNotificationsManager(gh<_i39.MyNotificationsRepository>()));
  gh.factory<_i87.MyNotificationsService>(
      () => _i87.MyNotificationsService(gh<_i86.MyNotificationsManager>()));
  gh.factory<_i88.MyNotificationsStateManager>(() =>
      _i88.MyNotificationsStateManager(gh<_i87.MyNotificationsService>(),
          gh<_i44.OrdersService>(), gh<_i25.AuthService>()));
  gh.factory<_i89.NewOrderLinkStateManager>(
      () => _i89.NewOrderLinkStateManager(gh<_i44.OrdersService>()));
  gh.factory<_i90.NewOrderStateManager>(
      () => _i90.NewOrderStateManager(gh<_i44.OrdersService>()));
  gh.factory<_i91.NewTestOrderStateManager>(
      () => _i91.NewTestOrderStateManager(gh<_i78.DevService>()));
  gh.factory<_i92.NoticeManager>(
      () => _i92.NoticeManager(gh<_i40.NoticeRepository>()));
  gh.factory<_i93.NoticeService>(
      () => _i93.NoticeService(gh<_i92.NoticeManager>()));
  gh.factory<_i94.NoticeStateManager>(
      () => _i94.NoticeStateManager(gh<_i93.NoticeService>()));
  gh.factory<_i95.OrderActionLogsStateManager>(
      () => _i95.OrderActionLogsStateManager(gh<_i44.OrdersService>()));
  gh.factory<_i96.OrderCaptainLogsStateManager>(
      () => _i96.OrderCaptainLogsStateManager(gh<_i44.OrdersService>()));
  gh.factory<_i97.OrderCashCaptainStateManager>(
      () => _i97.OrderCashCaptainStateManager(gh<_i44.OrdersService>()));
  gh.factory<_i98.OrderDistanceConflictStateManager>(
      () => _i98.OrderDistanceConflictStateManager(gh<_i44.OrdersService>()));
  gh.factory<_i99.OrderLogsStateManager>(
      () => _i99.OrderLogsStateManager(gh<_i44.OrdersService>()));
  gh.factory<_i100.OrderPendingStateManager>(
      () => _i100.OrderPendingStateManager(gh<_i44.OrdersService>()));
  gh.factory<_i101.OrderWithoutDistanceStateManager>(
      () => _i101.OrderWithoutDistanceStateManager(gh<_i44.OrdersService>()));
  gh.factory<_i102.OrdersCashCaptainScreen>(() =>
      _i102.OrdersCashCaptainScreen(gh<_i97.OrderCashCaptainStateManager>()));
  gh.factory<_i103.OrdersCashStoreStateManager>(
      () => _i103.OrdersCashStoreStateManager(gh<_i44.OrdersService>()));
  gh.factory<_i104.OrdersReceiveCashStateManager>(
      () => _i104.OrdersReceiveCashStateManager(gh<_i44.OrdersService>()));
  gh.factory<_i105.OrdersWithoutDistanceScreen>(() =>
      _i105.OrdersWithoutDistanceScreen(
          gh<_i101.OrderWithoutDistanceStateManager>()));
  gh.factory<_i106.PackageCategoriesStateManager>(() =>
      _i106.PackageCategoriesStateManager(
          gh<_i71.CategoriesService>(), gh<_i37.ImageUploadService>()));
  gh.factory<_i107.PackagesStateManager>(() => _i107.PackagesStateManager(
      gh<_i71.CategoriesService>(), gh<_i25.AuthService>()));
  gh.factory<_i108.PaymentsManager>(
      () => _i108.PaymentsManager(gh<_i45.PaymentsRepository>()));
  gh.factory<_i109.PaymentsService>(
      () => _i109.PaymentsService(gh<_i108.PaymentsManager>()));
  gh.factory<_i110.PaymentsToCaptainStateManager>(
      () => _i110.PaymentsToCaptainStateManager(gh<_i109.PaymentsService>()));
  gh.factory<_i111.PlanScreenStateManager>(
      () => _i111.PlanScreenStateManager(gh<_i109.PaymentsService>()));
  gh.factory<_i112.RecycleOrderScreen>(
      () => _i112.RecycleOrderScreen(gh<_i46.RecycleOrderStateManager>()));
  gh.factory<_i113.RegisterScreen>(
      () => _i113.RegisterScreen(gh<_i47.RegisterStateManager>()));
  gh.factory<_i114.SearchForOrderScreen>(
      () => _i114.SearchForOrderScreen(gh<_i48.SearchForOrderStateManager>()));
  gh.factory<_i115.SettingsScreen>(() => _i115.SettingsScreen(
      gh<_i25.AuthService>(),
      gh<_i11.LocalizationService>(),
      gh<_i20.AppThemeDataService>(),
      gh<_i79.FireNotificationService>()));
  gh.factory<_i116.SplashModule>(
      () => _i116.SplashModule(gh<_i49.SplashScreen>()));
  gh.factory<_i117.StatisticManager>(
      () => _i117.StatisticManager(gh<_i50.StatisticsRepository>()));
  gh.factory<_i118.StatisticsService>(
      () => _i118.StatisticsService(gh<_i117.StatisticManager>()));
  gh.factory<_i119.StatisticsStateManager>(
      () => _i119.StatisticsStateManager(gh<_i118.StatisticsService>()));
  gh.factory<_i120.StoreBalanceStateManager>(
      () => _i120.StoreBalanceStateManager(gh<_i109.PaymentsService>()));
  gh.factory<_i121.StoreManager>(
      () => _i121.StoreManager(gh<_i51.StoresRepository>()));
  gh.factory<_i122.StoresService>(() =>
      _i122.StoresService(gh<_i121.StoreManager>(), gh<_i43.OrdersManager>()));
  gh.factory<_i123.StoresStateManager>(() => _i123.StoresStateManager(
      gh<_i122.StoresService>(),
      gh<_i25.AuthService>(),
      gh<_i37.ImageUploadService>()));
  gh.factory<_i124.SubOrdersScreen>(
      () => _i124.SubOrdersScreen(gh<_i52.SubOrdersStateManager>()));
  gh.factory<_i125.SubscriptionsManager>(
      () => _i125.SubscriptionsManager(gh<_i53.SubscriptionsRepository>()));
  gh.factory<_i126.SubscriptionsService>(
      () => _i126.SubscriptionsService(gh<_i125.SubscriptionsManager>()));
  gh.factory<_i127.SupplierCategoriesManager>(() =>
      _i127.SupplierCategoriesManager(gh<_i54.SupplierCategoriesRepository>()));
  gh.factory<_i128.SupplierCategoriesService>(() =>
      _i128.SupplierCategoriesService(gh<_i127.SupplierCategoriesManager>()));
  gh.factory<_i129.SupplierCategoriesStateManager>(() =>
      _i129.SupplierCategoriesStateManager(
          gh<_i128.SupplierCategoriesService>(),
          gh<_i37.ImageUploadService>()));
  gh.factory<_i130.SupplierService>(
      () => _i130.SupplierService(gh<_i56.SuppliersManager>()));
  gh.factory<_i131.SuppliersStateManager>(
      () => _i131.SuppliersStateManager(gh<_i130.SupplierService>()));
  gh.factory<_i132.TopActiveStateManagment>(
      () => _i132.TopActiveStateManagment(gh<_i122.StoresService>()));
  gh.factory<_i133.TopActiveStoreScreen>(
      () => _i133.TopActiveStoreScreen(gh<_i132.TopActiveStateManagment>()));
  gh.factory<_i134.UpdateOrderScreen>(
      () => _i134.UpdateOrderScreen(gh<_i57.UpdateOrderStateManager>()));
  gh.factory<_i135.UpdatesStateManager>(() => _i135.UpdatesStateManager(
      gh<_i87.MyNotificationsService>(), gh<_i25.AuthService>()));
  gh.factory<_i136.AccountBalanceStateManager>(
      () => _i136.AccountBalanceStateManager(gh<_i64.CaptainsService>()));
  gh.factory<_i137.AuthorizationModule>(() => _i137.AuthorizationModule(
      gh<_i85.LoginScreen>(),
      gh<_i113.RegisterScreen>(),
      gh<_i80.ForgotPassScreen>()));
  gh.factory<_i138.BidOrderDetailsScreen>(
      () => _i138.BidOrderDetailsScreen(gh<_i60.BidOrderStateManager>()));
  gh.factory<_i139.BidOrderModule>(
      () => _i139.BidOrderModule(gh<_i61.BidOrdersScreen>()));
  gh.factory<_i140.BranchesListService>(
      () => _i140.BranchesListService(gh<_i62.BranchesManager>()));
  gh.factory<_i141.BranchesListStateManager>(
      () => _i141.BranchesListStateManager(gh<_i140.BranchesListService>()));
  gh.factory<_i142.CaptainAccountBalanceScreen>(() =>
      _i142.CaptainAccountBalanceScreen(
          gh<_i136.AccountBalanceStateManager>()));
  gh.factory<_i143.CaptainActivityDetailsStateManager>(() =>
      _i143.CaptainActivityDetailsStateManager(gh<_i64.CaptainsService>()));
  gh.factory<_i144.CaptainAssignOrderStateManager>(
      () => _i144.CaptainAssignOrderStateManager(gh<_i64.CaptainsService>()));
  gh.factory<_i145.CaptainFinanceByHoursStateManager>(() =>
      _i145.CaptainFinanceByHoursStateManager(gh<_i109.PaymentsService>()));
  gh.factory<_i146.CaptainFinanceByOrderCountStateManager>(() =>
      _i146.CaptainFinanceByOrderCountStateManager(
          gh<_i109.PaymentsService>()));
  gh.factory<_i147.CaptainFinanceByOrderStateManager>(() =>
      _i147.CaptainFinanceByOrderStateManager(gh<_i109.PaymentsService>()));
  gh.factory<_i148.CaptainFinanceDailyStateManager>(
      () => _i148.CaptainFinanceDailyStateManager(gh<_i64.CaptainsService>()));
  gh.factory<_i149.CaptainFinancialDuesDetailsStateManager>(() =>
      _i149.CaptainFinancialDuesDetailsStateManager(
          gh<_i109.PaymentsService>(), gh<_i64.CaptainsService>()));
  gh.factory<_i150.CaptainFinancialDuesStateManager>(
      () => _i150.CaptainFinancialDuesStateManager(gh<_i64.CaptainsService>()));
  gh.factory<_i151.CaptainOfferStateManager>(() =>
      _i151.CaptainOfferStateManager(
          gh<_i64.CaptainsService>(), gh<_i37.ImageUploadService>()));
  gh.factory<_i152.CaptainOffersScreen>(
      () => _i152.CaptainOffersScreen(gh<_i151.CaptainOfferStateManager>()));
  gh.factory<_i153.CaptainProfileStateManager>(
      () => _i153.CaptainProfileStateManager(gh<_i64.CaptainsService>()));
  gh.factory<_i154.CaptainsActivityStateManager>(
      () => _i154.CaptainsActivityStateManager(gh<_i64.CaptainsService>()));
  gh.factory<_i155.CaptainsNeedsSupportStateManager>(
      () => _i155.CaptainsNeedsSupportStateManager(gh<_i64.CaptainsService>()));
  gh.factory<_i156.CaptainsRatingStateManager>(
      () => _i156.CaptainsRatingStateManager(gh<_i64.CaptainsService>()));
  gh.factory<_i157.CaptainsScreen>(
      () => _i157.CaptainsScreen(gh<_i65.CaptainsStateManager>()));
  gh.factory<_i158.CaptinRatingDetailsScreen>(() =>
      _i158.CaptinRatingDetailsScreen(
          gh<_i66.CaptinRatingDetailsStateManager>()));
  gh.factory<_i159.CarsScreen>(
      () => _i159.CarsScreen(gh<_i69.CarsStateManager>()));
  gh.factory<_i160.CategoriesScreen>(
      () => _i160.CategoriesScreen(gh<_i106.PackageCategoriesStateManager>()));
  gh.factory<_i161.ChatPage>(() => _i161.ChatPage(
      gh<_i74.ChatStateManager>(),
      gh<_i37.ImageUploadService>(),
      gh<_i25.AuthService>(),
      gh<_i6.ChatHiveHelper>()));
  gh.factory<_i162.CompanyFinanceStateManager>(() =>
      _i162.CompanyFinanceStateManager(
          gh<_i25.AuthService>(), gh<_i76.CompanyService>()));
  gh.factory<_i163.CompanyProfileStateManager>(() =>
      _i163.CompanyProfileStateManager(
          gh<_i25.AuthService>(), gh<_i76.CompanyService>()));
  gh.factory<_i164.DailyBalanceStateManager>(() =>
      _i164.DailyBalanceStateManager(gh<_i109.PaymentsService>(),
          gh<_i25.AuthService>(), gh<_i37.ImageUploadService>()));
  gh.factory<_i165.DailyPaymentsScreen>(
      () => _i165.DailyPaymentsScreen(gh<_i164.DailyBalanceStateManager>()));
  gh.factory<_i166.EditSubscriptionStateManager>(() =>
      _i166.EditSubscriptionStateManager(gh<_i126.SubscriptionsService>()));
  gh.factory<_i167.FilterOrderTopStateManager>(
      () => _i167.FilterOrderTopStateManager(gh<_i122.StoresService>()));
  gh.factory<_i168.HomeScreen>(
      () => _i168.HomeScreen(gh<_i83.HomeStateManager>()));
  gh.factory<_i169.InActiveCaptainsScreen>(() =>
      _i169.InActiveCaptainsScreen(gh<_i84.InActiveCaptainsStateManager>()));
  gh.factory<_i170.InActiveSupplierStateManager>(
      () => _i170.InActiveSupplierStateManager(gh<_i130.SupplierService>()));
  gh.factory<_i171.InitBranchesStateManager>(
      () => _i171.InitBranchesStateManager(gh<_i140.BranchesListService>()));
  gh.factory<_i172.InitSubscriptionStateManager>(() =>
      _i172.InitSubscriptionStateManager(gh<_i126.SubscriptionsService>()));
  gh.factory<_i173.MyNotificationsScreen>(() =>
      _i173.MyNotificationsScreen(gh<_i88.MyNotificationsStateManager>()));
  gh.factory<_i174.NewOrderLinkScreen>(
      () => _i174.NewOrderLinkScreen(gh<_i89.NewOrderLinkStateManager>()));
  gh.factory<_i175.NewOrderScreen>(
      () => _i175.NewOrderScreen(gh<_i90.NewOrderStateManager>()));
  gh.factory<_i176.NewTestOrderScreen>(
      () => _i176.NewTestOrderScreen(gh<_i91.NewTestOrderStateManager>()));
  gh.factory<_i177.NoticeScreen>(
      () => _i177.NoticeScreen(gh<_i94.NoticeStateManager>()));
  gh.factory<_i178.OrderActionLogsScreen>(() =>
      _i178.OrderActionLogsScreen(gh<_i95.OrderActionLogsStateManager>()));
  gh.factory<_i179.OrderCaptainLogsScreen>(() =>
      _i179.OrderCaptainLogsScreen(gh<_i96.OrderCaptainLogsStateManager>()));
  gh.factory<_i180.OrderCaptainNotArrivedStateManager>(() =>
      _i180.OrderCaptainNotArrivedStateManager(gh<_i122.StoresService>()));
  gh.factory<_i181.OrderDistanceConflictScreen>(() =>
      _i181.OrderDistanceConflictScreen(
          gh<_i98.OrderDistanceConflictStateManager>()));
  gh.factory<_i182.OrderLogsScreen>(
      () => _i182.OrderLogsScreen(gh<_i99.OrderLogsStateManager>()));
  gh.factory<_i183.OrderLogsStateManager>(
      () => _i183.OrderLogsStateManager(gh<_i122.StoresService>()));
  gh.factory<_i184.OrderPendingScreen>(
      () => _i184.OrderPendingScreen(gh<_i100.OrderPendingStateManager>()));
  gh.factory<_i185.OrderStatusStateManager>(() => _i185.OrderStatusStateManager(
      gh<_i122.StoresService>(), gh<_i25.AuthService>()));
  gh.factory<_i186.OrderTimeLineStateManager>(() =>
      _i186.OrderTimeLineStateManager(
          gh<_i122.StoresService>(), gh<_i25.AuthService>()));
  gh.factory<_i187.OrdersCashStoreScreen>(() =>
      _i187.OrdersCashStoreScreen(gh<_i103.OrdersCashStoreStateManager>()));
  gh.factory<_i188.OrdersReceiveCashScreen>(() =>
      _i188.OrdersReceiveCashScreen(gh<_i104.OrdersReceiveCashStateManager>()));
  gh.factory<_i189.OrdersTopActiveStoreScreen>(() =>
      _i189.OrdersTopActiveStoreScreen(gh<_i167.FilterOrderTopStateManager>()));
  gh.factory<_i190.PackagesScreen>(
      () => _i190.PackagesScreen(gh<_i107.PackagesStateManager>()));
  gh.factory<_i191.PaymentsToCaptainScreen>(() =>
      _i191.PaymentsToCaptainScreen(gh<_i110.PaymentsToCaptainStateManager>()));
  gh.factory<_i192.PlanScreen>(
      () => _i192.PlanScreen(gh<_i111.PlanScreenStateManager>()));
  gh.factory<_i193.SettingsModule>(() => _i193.SettingsModule(
      gh<_i115.SettingsScreen>(), gh<_i22.ChooseLocalScreen>()));
  gh.factory<_i194.StatisticsScreen>(
      () => _i194.StatisticsScreen(gh<_i119.StatisticsStateManager>()));
  gh.factory<_i195.StoreBalanceScreen>(
      () => _i195.StoreBalanceScreen(gh<_i120.StoreBalanceStateManager>()));
  gh.factory<_i196.StoreDuesStateManager>(() => _i196.StoreDuesStateManager(
      gh<_i122.StoresService>(), gh<_i109.PaymentsService>()));
  gh.factory<_i197.StoreFinancialSubscriptionsDuesDetailsStateManager>(() =>
      _i197.StoreFinancialSubscriptionsDuesDetailsStateManager(
          gh<_i109.PaymentsService>(), gh<_i126.SubscriptionsService>()));
  gh.factory<_i198.StoreProfileStateManager>(() =>
      _i198.StoreProfileStateManager(
          gh<_i122.StoresService>(), gh<_i37.ImageUploadService>()));
  gh.factory<_i199.StoreSubscriptionManagementStateManager>(() =>
      _i199.StoreSubscriptionManagementStateManager(
          gh<_i126.SubscriptionsService>()));
  gh.factory<_i200.StoreSubscriptionsExpiredFinanceStateManager>(() =>
      _i200.StoreSubscriptionsExpiredFinanceStateManager(
          gh<_i126.SubscriptionsService>()));
  gh.factory<_i201.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i201.StoreSubscriptionsFinanceDetailsScreen(
          gh<_i197.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i202.StoreSubscriptionsFinanceStateManager>(() =>
      _i202.StoreSubscriptionsFinanceStateManager(
          gh<_i126.SubscriptionsService>()));
  gh.factory<_i203.StoresDuesStateManager>(
      () => _i203.StoresDuesStateManager(gh<_i122.StoresService>()));
  gh.factory<_i204.StoresInActiveStateManager>(() =>
      _i204.StoresInActiveStateManager(gh<_i122.StoresService>(),
          gh<_i25.AuthService>(), gh<_i37.ImageUploadService>()));
  gh.factory<_i205.StoresNeedsSupportStateManager>(
      () => _i205.StoresNeedsSupportStateManager(gh<_i122.StoresService>()));
  gh.factory<_i206.StoresScreen>(
      () => _i206.StoresScreen(gh<_i123.StoresStateManager>()));
  gh.factory<_i207.SubscriptionManagementScreen>(() =>
      _i207.SubscriptionManagementScreen(
          gh<_i199.StoreSubscriptionManagementStateManager>()));
  gh.factory<_i208.SubscriptionToCaptainOfferStateManager>(() =>
      _i208.SubscriptionToCaptainOfferStateManager(
          gh<_i126.SubscriptionsService>()));
  gh.factory<_i209.SupplierAdsStateManager>(
      () => _i209.SupplierAdsStateManager(gh<_i130.SupplierService>()));
  gh.factory<_i210.SupplierCategoriesScreen>(() =>
      _i210.SupplierCategoriesScreen(
          gh<_i129.SupplierCategoriesStateManager>()));
  gh.factory<_i211.SupplierNeedsSupportStateManager>(() =>
      _i211.SupplierNeedsSupportStateManager(gh<_i130.SupplierService>()));
  gh.factory<_i212.SupplierProfileStateManager>(
      () => _i212.SupplierProfileStateManager(gh<_i130.SupplierService>()));
  gh.factory<_i213.SuppliersScreen>(
      () => _i213.SuppliersScreen(gh<_i131.SuppliersStateManager>()));
  gh.factory<_i214.UpdateBranchStateManager>(
      () => _i214.UpdateBranchStateManager(gh<_i140.BranchesListService>()));
  gh.factory<_i215.UpdateScreen>(
      () => _i215.UpdateScreen(gh<_i135.UpdatesStateManager>()));
  gh.factory<_i216.AllAmountCaptainsScreen>(() =>
      _i216.AllAmountCaptainsScreen(gh<_i164.DailyBalanceStateManager>()));
  gh.factory<_i217.BranchesListScreen>(
      () => _i217.BranchesListScreen(gh<_i141.BranchesListStateManager>()));
  gh.factory<_i218.CaptainActivityDetailsScreen>(() =>
      _i218.CaptainActivityDetailsScreen(
          gh<_i143.CaptainActivityDetailsStateManager>()));
  gh.factory<_i219.CaptainAssignOrderScreen>(() =>
      _i219.CaptainAssignOrderScreen(
          gh<_i144.CaptainAssignOrderStateManager>()));
  gh.factory<_i220.CaptainFinanceByCountOrderScreen>(() =>
      _i220.CaptainFinanceByCountOrderScreen(
          gh<_i146.CaptainFinanceByOrderCountStateManager>()));
  gh.factory<_i221.CaptainFinanceByHoursScreen>(() =>
      _i221.CaptainFinanceByHoursScreen(
          gh<_i145.CaptainFinanceByHoursStateManager>()));
  gh.factory<_i222.CaptainFinanceByOrderScreen>(() =>
      _i222.CaptainFinanceByOrderScreen(
          gh<_i147.CaptainFinanceByOrderStateManager>()));
  gh.factory<_i223.CaptainFinanceDailyScreen>(() =>
      _i223.CaptainFinanceDailyScreen(
          gh<_i148.CaptainFinanceDailyStateManager>()));
  gh.factory<_i224.CaptainFinancialDuesDetailsScreen>(() =>
      _i224.CaptainFinancialDuesDetailsScreen(
          gh<_i149.CaptainFinancialDuesDetailsStateManager>()));
  gh.factory<_i225.CaptainFinancialDuesScreen>(() =>
      _i225.CaptainFinancialDuesScreen(
          gh<_i150.CaptainFinancialDuesStateManager>()));
  gh.factory<_i226.CaptainProfileScreen>(
      () => _i226.CaptainProfileScreen(gh<_i153.CaptainProfileStateManager>()));
  gh.factory<_i227.CaptainsActivityScreen>(() =>
      _i227.CaptainsActivityScreen(gh<_i154.CaptainsActivityStateManager>()));
  gh.factory<_i228.CaptainsNeedsSupportScreen>(() =>
      _i228.CaptainsNeedsSupportScreen(
          gh<_i155.CaptainsNeedsSupportStateManager>()));
  gh.factory<_i229.CaptainsRatingScreen>(
      () => _i229.CaptainsRatingScreen(gh<_i156.CaptainsRatingStateManager>()));
  gh.factory<_i230.CarsModule>(() => _i230.CarsModule(gh<_i159.CarsScreen>()));
  gh.factory<_i231.CategoriesModule>(() => _i231.CategoriesModule(
      gh<_i160.CategoriesScreen>(), gh<_i190.PackagesScreen>()));
  gh.factory<_i232.ChatModule>(
      () => _i232.ChatModule(gh<_i161.ChatPage>(), gh<_i25.AuthService>()));
  gh.factory<_i233.CompanyFinanceScreen>(
      () => _i233.CompanyFinanceScreen(gh<_i162.CompanyFinanceStateManager>()));
  gh.factory<_i234.CompanyProfileScreen>(
      () => _i234.CompanyProfileScreen(gh<_i163.CompanyProfileStateManager>()));
  gh.factory<_i235.CreateSubscriptionScreen>(() =>
      _i235.CreateSubscriptionScreen(gh<_i172.InitSubscriptionStateManager>()));
  gh.factory<_i236.CreateSubscriptionToCaptainOfferScreen>(() =>
      _i236.CreateSubscriptionToCaptainOfferScreen(
          gh<_i208.SubscriptionToCaptainOfferStateManager>()));
  gh.factory<_i237.DevModule>(
      () => _i237.DevModule(gh<_i176.NewTestOrderScreen>()));
  gh.factory<_i238.EditSubscriptionScreen>(() =>
      _i238.EditSubscriptionScreen(gh<_i166.EditSubscriptionStateManager>()));
  gh.factory<_i239.InActiveSupplierScreen>(() =>
      _i239.InActiveSupplierScreen(gh<_i170.InActiveSupplierStateManager>()));
  gh.factory<_i240.InitBranchesScreen>(
      () => _i240.InitBranchesScreen(gh<_i171.InitBranchesStateManager>()));
  gh.factory<_i241.MainScreen>(
      () => _i241.MainScreen(gh<_i194.StatisticsScreen>()));
  gh.factory<_i242.MyNotificationsModule>(() => _i242.MyNotificationsModule(
      gh<_i173.MyNotificationsScreen>(), gh<_i215.UpdateScreen>()));
  gh.factory<_i243.NoticeModule>(
      () => _i243.NoticeModule(gh<_i177.NoticeScreen>()));
  gh.factory<_i244.OrderCaptainNotArrivedScreen>(() =>
      _i244.OrderCaptainNotArrivedScreen(
          gh<_i180.OrderCaptainNotArrivedStateManager>()));
  gh.factory<_i245.OrderDetailsScreen>(
      () => _i245.OrderDetailsScreen(gh<_i185.OrderStatusStateManager>()));
  gh.factory<_i246.OrderLogsScreen>(
      () => _i246.OrderLogsScreen(gh<_i183.OrderLogsStateManager>()));
  gh.factory<_i247.OrderTimeLineScreen>(
      () => _i247.OrderTimeLineScreen(gh<_i186.OrderTimeLineStateManager>()));
  gh.factory<_i248.OrdersModule>(() => _i248.OrdersModule(
      gh<_i182.OrderLogsScreen>(),
      gh<_i102.OrdersCashCaptainScreen>(),
      gh<_i187.OrdersCashStoreScreen>(),
      gh<_i134.UpdateOrderScreen>(),
      gh<_i184.OrderPendingScreen>(),
      gh<_i175.NewOrderScreen>(),
      gh<_i179.OrderCaptainLogsScreen>(),
      gh<_i178.OrderActionLogsScreen>(),
      gh<_i105.OrdersWithoutDistanceScreen>(),
      gh<_i188.OrdersReceiveCashScreen>(),
      gh<_i124.SubOrdersScreen>(),
      gh<_i174.NewOrderLinkScreen>(),
      gh<_i114.SearchForOrderScreen>(),
      gh<_i112.RecycleOrderScreen>(),
      gh<_i181.OrderDistanceConflictScreen>()));
  gh.factory<_i249.PaymentsModule>(() => _i249.PaymentsModule(
      gh<_i220.CaptainFinanceByCountOrderScreen>(),
      gh<_i221.CaptainFinanceByHoursScreen>(),
      gh<_i222.CaptainFinanceByOrderScreen>(),
      gh<_i191.PaymentsToCaptainScreen>(),
      gh<_i195.StoreBalanceScreen>(),
      gh<_i165.DailyPaymentsScreen>(),
      gh<_i216.AllAmountCaptainsScreen>()));
  gh.factory<_i250.StatisticsModule>(
      () => _i250.StatisticsModule(gh<_i194.StatisticsScreen>()));
  gh.factory<_i251.StoreDuesScreen>(
      () => _i251.StoreDuesScreen(gh<_i196.StoreDuesStateManager>()));
  gh.factory<_i252.StoreInfoScreen>(
      () => _i252.StoreInfoScreen(gh<_i198.StoreProfileStateManager>()));
  gh.factory<_i253.StoreSubscriptionsExpiredFinanceScreen>(() =>
      _i253.StoreSubscriptionsExpiredFinanceScreen(
          gh<_i200.StoreSubscriptionsExpiredFinanceStateManager>()));
  gh.factory<_i254.StoreSubscriptionsFinanceScreen>(() =>
      _i254.StoreSubscriptionsFinanceScreen(
          gh<_i202.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i255.StoresDuesScreen>(
      () => _i255.StoresDuesScreen(gh<_i203.StoresDuesStateManager>()));
  gh.factory<_i256.StoresInActiveScreen>(
      () => _i256.StoresInActiveScreen(gh<_i204.StoresInActiveStateManager>()));
  gh.factory<_i257.StoresNeedsSupportScreen>(() =>
      _i257.StoresNeedsSupportScreen(
          gh<_i205.StoresNeedsSupportStateManager>()));
  gh.factory<_i258.SubscriptionsModule>(() => _i258.SubscriptionsModule(
      gh<_i201.StoreSubscriptionsFinanceDetailsScreen>(),
      gh<_i254.StoreSubscriptionsFinanceScreen>(),
      gh<_i207.SubscriptionManagementScreen>(),
      gh<_i253.StoreSubscriptionsExpiredFinanceScreen>(),
      gh<_i235.CreateSubscriptionScreen>(),
      gh<_i236.CreateSubscriptionToCaptainOfferScreen>(),
      gh<_i238.EditSubscriptionScreen>()));
  gh.factory<_i259.SupplierAdsScreen>(
      () => _i259.SupplierAdsScreen(gh<_i209.SupplierAdsStateManager>()));
  gh.factory<_i260.SupplierCategoriesModule>(() =>
      _i260.SupplierCategoriesModule(gh<_i210.SupplierCategoriesScreen>()));
  gh.factory<_i261.SupplierNeedsSupportScreen>(() =>
      _i261.SupplierNeedsSupportScreen(
          gh<_i211.SupplierNeedsSupportStateManager>()));
  gh.factory<_i262.SupplierProfileScreen>(() =>
      _i262.SupplierProfileScreen(gh<_i212.SupplierProfileStateManager>()));
  gh.factory<_i263.UpdateBranchScreen>(
      () => _i263.UpdateBranchScreen(gh<_i214.UpdateBranchStateManager>()));
  gh.factory<_i264.BranchesModule>(() => _i264.BranchesModule(
      gh<_i217.BranchesListScreen>(),
      gh<_i263.UpdateBranchScreen>(),
      gh<_i240.InitBranchesScreen>()));
  gh.factory<_i265.CaptainsModule>(() => _i265.CaptainsModule(
      gh<_i152.CaptainOffersScreen>(),
      gh<_i169.InActiveCaptainsScreen>(),
      gh<_i157.CaptainsScreen>(),
      gh<_i226.CaptainProfileScreen>(),
      gh<_i228.CaptainsNeedsSupportScreen>(),
      gh<_i142.CaptainAccountBalanceScreen>(),
      gh<_i224.CaptainFinancialDuesDetailsScreen>(),
      gh<_i225.CaptainFinancialDuesScreen>(),
      gh<_i192.PlanScreen>(),
      gh<_i219.CaptainAssignOrderScreen>(),
      gh<_i229.CaptainsRatingScreen>(),
      gh<_i158.CaptinRatingDetailsScreen>(),
      gh<_i227.CaptainsActivityScreen>(),
      gh<_i218.CaptainActivityDetailsScreen>(),
      gh<_i223.CaptainFinanceDailyScreen>()));
  gh.factory<_i266.CompanyModule>(() => _i266.CompanyModule(
      gh<_i234.CompanyProfileScreen>(), gh<_i233.CompanyFinanceScreen>()));
  gh.factory<_i267.MainModule>(
      () => _i267.MainModule(gh<_i241.MainScreen>(), gh<_i168.HomeScreen>()));
  gh.factory<_i268.StoresModule>(() => _i268.StoresModule(
      gh<_i206.StoresScreen>(),
      gh<_i252.StoreInfoScreen>(),
      gh<_i256.StoresInActiveScreen>(),
      gh<_i195.StoreBalanceScreen>(),
      gh<_i257.StoresNeedsSupportScreen>(),
      gh<_i245.OrderDetailsScreen>(),
      gh<_i246.OrderLogsScreen>(),
      gh<_i244.OrderCaptainNotArrivedScreen>(),
      gh<_i247.OrderTimeLineScreen>(),
      gh<_i133.TopActiveStoreScreen>(),
      gh<_i189.OrdersTopActiveStoreScreen>(),
      gh<_i255.StoresDuesScreen>(),
      gh<_i251.StoreDuesScreen>()));
  gh.factory<_i269.SupplierModule>(() => _i269.SupplierModule(
      gh<_i239.InActiveSupplierScreen>(),
      gh<_i213.SuppliersScreen>(),
      gh<_i262.SupplierProfileScreen>(),
      gh<_i261.SupplierNeedsSupportScreen>(),
      gh<_i259.SupplierAdsScreen>()));
  gh.factory<_i270.MyApp>(() => _i270.MyApp(
      gh<_i20.AppThemeDataService>(),
      gh<_i11.LocalizationService>(),
      gh<_i79.FireNotificationService>(),
      gh<_i9.LocalNotificationService>(),
      gh<_i116.SplashModule>(),
      gh<_i137.AuthorizationModule>(),
      gh<_i232.ChatModule>(),
      gh<_i193.SettingsModule>(),
      gh<_i267.MainModule>(),
      gh<_i268.StoresModule>(),
      gh<_i231.CategoriesModule>(),
      gh<_i266.CompanyModule>(),
      gh<_i264.BranchesModule>(),
      gh<_i243.NoticeModule>(),
      gh<_i265.CaptainsModule>(),
      gh<_i249.PaymentsModule>(),
      gh<_i260.SupplierCategoriesModule>(),
      gh<_i269.SupplierModule>(),
      gh<_i230.CarsModule>(),
      gh<_i139.BidOrderModule>(),
      gh<_i248.OrdersModule>(),
      gh<_i258.SubscriptionsModule>(),
      gh<_i242.MyNotificationsModule>(),
      gh<_i250.StatisticsModule>(),
      gh<_i237.DevModule>()));
  return getIt;
}
