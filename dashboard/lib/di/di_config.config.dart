// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:c4d/hive/util/argument_hive_helper.dart' as _i3;
import 'package:c4d/main.dart' as _i259;
import 'package:c4d/module_auth/authoriazation_module.dart' as _i132;
import 'package:c4d/module_auth/manager/auth_manager/auth_manager.dart' as _i23;
import 'package:c4d/module_auth/presistance/auth_prefs_helper.dart' as _i4;
import 'package:c4d/module_auth/repository/auth/auth_repository.dart' as _i20;
import 'package:c4d/module_auth/service/auth_service/auth_service.dart' as _i24;
import 'package:c4d/module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i33;
import 'package:c4d/module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i36;
import 'package:c4d/module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i45;
import 'package:c4d/module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i76;
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart'
    as _i81;
import 'package:c4d/module_auth/ui/screen/register_screen/register_screen.dart'
    as _i108;
import 'package:c4d/module_bid_order/bid_order_module.dart' as _i134;
import 'package:c4d/module_bid_order/manager/bid_order_manager.dart' as _i56;
import 'package:c4d/module_bid_order/repository/bid_order_repository.dart'
    as _i25;
import 'package:c4d/module_bid_order/service/bid_order_service.dart' as _i57;
import 'package:c4d/module_bid_order/state_manager/bid_order_state_manager.dart'
    as _i58;
import 'package:c4d/module_bid_order/ui/screen/bid_orders_screen.dart' as _i59;
import 'package:c4d/module_bid_order/ui/screen/order_details_screen.dart'
    as _i133;
import 'package:c4d/module_branches/branches_module.dart' as _i254;
import 'package:c4d/module_branches/manager/branches_manager.dart' as _i60;
import 'package:c4d/module_branches/repository/branches_repository.dart'
    as _i26;
import 'package:c4d/module_branches/service/branches_list_service.dart'
    as _i135;
import 'package:c4d/module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i136;
import 'package:c4d/module_branches/state_manager/init_branches_state_manager.dart'
    as _i166;
import 'package:c4d/module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i207;
import 'package:c4d/module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i210;
import 'package:c4d/module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i232;
import 'package:c4d/module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i253;
import 'package:c4d/module_captain/captains_module.dart' as _i255;
import 'package:c4d/module_captain/hive/captain_hive_helper.dart' as _i5;
import 'package:c4d/module_captain/manager/captains_manager.dart' as _i61;
import 'package:c4d/module_captain/repository/captains_repository.dart' as _i27;
import 'package:c4d/module_captain/service/captains_service.dart' as _i62;
import 'package:c4d/module_captain/state_manager/captain_account_balance_state_manager.dart'
    as _i131;
import 'package:c4d/module_captain/state_manager/captain_activity_details_state_manager.dart'
    as _i138;
import 'package:c4d/module_captain/state_manager/captain_activity_state_manager.dart'
    as _i149;
import 'package:c4d/module_captain/state_manager/captain_finance_daily_state_manager.dart'
    as _i143;
import 'package:c4d/module_captain/state_manager/captain_financial_dues_details_state_manager.dart'
    as _i144;
import 'package:c4d/module_captain/state_manager/captain_financial_dues_state_manager.dart'
    as _i145;
import 'package:c4d/module_captain/state_manager/captain_list.dart' as _i63;
import 'package:c4d/module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i150;
import 'package:c4d/module_captain/state_manager/captain_offer_state_manager.dart'
    as _i146;
import 'package:c4d/module_captain/state_manager/captain_order_assign_state_manager.dart'
    as _i139;
import 'package:c4d/module_captain/state_manager/captain_profile_state_manager.dart'
    as _i148;
import 'package:c4d/module_captain/state_manager/captain_rating_state_manager.dart'
    as _i151;
import 'package:c4d/module_captain/state_manager/captin_rating_details_state_manager.dart'
    as _i64;
import 'package:c4d/module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i80;
import 'package:c4d/module_captain/state_manager/plan_screen_state_manager.dart'
    as _i106;
import 'package:c4d/module_captain/ui/screen/captain_account_balance_screen.dart'
    as _i137;
import 'package:c4d/module_captain/ui/screen/captain_activity_details_screen.dart'
    as _i211;
import 'package:c4d/module_captain/ui/screen/captain_activity_model.dart'
    as _i220;
import 'package:c4d/module_captain/ui/screen/captain_finance_daily_screen.dart'
    as _i216;
import 'package:c4d/module_captain/ui/screen/captain_financial_details_screen.dart'
    as _i217;
import 'package:c4d/module_captain/ui/screen/captain_financial_dues_screen.dart'
    as _i218;
import 'package:c4d/module_captain/ui/screen/captain_needs_support_screen.dart'
    as _i221;
import 'package:c4d/module_captain/ui/screen/captain_profile_screen.dart'
    as _i219;
import 'package:c4d/module_captain/ui/screen/captain_rating_screen.dart'
    as _i222;
import 'package:c4d/module_captain/ui/screen/captains_assign_order_screen.dart'
    as _i212;
import 'package:c4d/module_captain/ui/screen/captains_list_screen.dart'
    as _i152;
import 'package:c4d/module_captain/ui/screen/captains_offer_screen.dart'
    as _i147;
import 'package:c4d/module_captain/ui/screen/captin_rating_details_state.dart'
    as _i153;
import 'package:c4d/module_captain/ui/screen/change_captain_plan_screen.dart'
    as _i187;
import 'package:c4d/module_captain/ui/screen/in_active_captains_screen.dart'
    as _i164;
import 'package:c4d/module_categories/categories_module.dart' as _i224;
import 'package:c4d/module_categories/manager/categories_manager.dart' as _i68;
import 'package:c4d/module_categories/repository/categories_repository.dart'
    as _i29;
import 'package:c4d/module_categories/service/store_categories_service.dart'
    as _i69;
import 'package:c4d/module_categories/state_manager/categories_state_manager.dart'
    as _i101;
import 'package:c4d/module_categories/state_manager/packages_state_manager.dart'
    as _i102;
import 'package:c4d/module_categories/ui/screen/categories_screen.dart'
    as _i155;
import 'package:c4d/module_categories/ui/screen/packages_screen.dart' as _i185;
import 'package:c4d/module_chat/chat_module.dart' as _i225;
import 'package:c4d/module_chat/manager/chat/chat_manager.dart' as _i70;
import 'package:c4d/module_chat/presistance/chat_hive_helper.dart' as _i6;
import 'package:c4d/module_chat/repository/chat/chat_repository.dart' as _i30;
import 'package:c4d/module_chat/service/chat/char_service.dart' as _i71;
import 'package:c4d/module_chat/state_manager/chat_state_manager.dart' as _i72;
import 'package:c4d/module_chat/ui/screens/chat_page/chat_page.dart' as _i156;
import 'package:c4d/module_company/company_module.dart' as _i256;
import 'package:c4d/module_company/manager/company_manager.dart' as _i73;
import 'package:c4d/module_company/repository/company_repository.dart' as _i31;
import 'package:c4d/module_company/service/company_service.dart' as _i74;
import 'package:c4d/module_company/state_manager/company_financial_state_manager.dart'
    as _i157;
import 'package:c4d/module_company/state_manager/company_profile_state_manager.dart'
    as _i158;
import 'package:c4d/module_company/ui/screen/company_finance_screen.dart'
    as _i226;
import 'package:c4d/module_company/ui/screen/company_profile_screen.dart'
    as _i227;
import 'package:c4d/module_deep_links/repository/deep_link_repository.dart'
    as _i32;
import 'package:c4d/module_delivary_car/cars_module.dart' as _i223;
import 'package:c4d/module_delivary_car/manager/cars_manager.dart' as _i65;
import 'package:c4d/module_delivary_car/repository/cars_repository.dart'
    as _i28;
import 'package:c4d/module_delivary_car/service/cars_service.dart' as _i66;
import 'package:c4d/module_delivary_car/state_manager/cars_state_manager.dart'
    as _i67;
import 'package:c4d/module_delivary_car/ui/screen/cars_screen.dart' as _i154;
import 'package:c4d/module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i10;
import 'package:c4d/module_localization/service/localization_service/localization_service.dart'
    as _i11;
import 'package:c4d/module_main/main_module.dart' as _i233;
import 'package:c4d/module_main/manager/home_manager.dart' as _i77;
import 'package:c4d/module_main/repository/home_repository.dart' as _i34;
import 'package:c4d/module_main/sceen/home_screen.dart' as _i163;
import 'package:c4d/module_main/sceen/main_screen.dart' as _i168;
import 'package:c4d/module_main/service/home_service.dart' as _i78;
import 'package:c4d/module_main/state_manager/home_state_manager.dart' as _i79;
import 'package:c4d/module_my_notifications/manager/my_notifications_manager.dart'
    as _i82;
import 'package:c4d/module_my_notifications/my_notifications_module.dart'
    as _i234;
import 'package:c4d/module_my_notifications/repository/my_notifications_repository.dart'
    as _i37;
import 'package:c4d/module_my_notifications/service/my_notification_service.dart'
    as _i83;
import 'package:c4d/module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i84;
import 'package:c4d/module_my_notifications/state_manager/update_state_manager.dart'
    as _i130;
import 'package:c4d/module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i169;
import 'package:c4d/module_my_notifications/ui/screen/update_screen.dart'
    as _i208;
import 'package:c4d/module_network/http_client/http_client.dart' as _i18;
import 'package:c4d/module_notice/manager/notice_manager.dart' as _i87;
import 'package:c4d/module_notice/notice_module.dart' as _i235;
import 'package:c4d/module_notice/repository/notice_repository.dart' as _i38;
import 'package:c4d/module_notice/service/notice_service.dart' as _i88;
import 'package:c4d/module_notice/state_manager/notice_state_manager.dart'
    as _i89;
import 'package:c4d/module_notice/ui/screen/notice_screen.dart' as _i172;
import 'package:c4d/module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i13;
import 'package:c4d/module_notifications/repository/notification_repo.dart'
    as _i39;
import 'package:c4d/module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i75;
import 'package:c4d/module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i9;
import 'package:c4d/module_orders/hive/order_hive_helper.dart' as _i14;
import 'package:c4d/module_orders/manager/orders_manager/orders_manager.dart'
    as _i41;
import 'package:c4d/module_orders/orders_module.dart' as _i240;
import 'package:c4d/module_orders/repository/order_repository/order_repository.dart'
    as _i40;
import 'package:c4d/module_orders/service/orders/orders.service.dart' as _i42;
import 'package:c4d/module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i86;
import 'package:c4d/module_orders/state_manager/new_order/new_order_link_state_manager.dart'
    as _i85;
import 'package:c4d/module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i55;
import 'package:c4d/module_orders/state_manager/order_action_logs_state_manager.dart'
    as _i90;
import 'package:c4d/module_orders/state_manager/order_captain_logs_state_manager.dart'
    as _i91;
import 'package:c4d/module_orders/state_manager/order_cash_captain_state_manager.dart'
    as _i92;
import 'package:c4d/module_orders/state_manager/order_cash_store_state_manager.dart'
    as _i98;
import 'package:c4d/module_orders/state_manager/order_distance_conflict_state_manager.dart'
    as _i93;
import 'package:c4d/module_orders/state_manager/order_logs_state_manager.dart'
    as _i94;
import 'package:c4d/module_orders/state_manager/order_pending_state_manager.dart'
    as _i95;
import 'package:c4d/module_orders/state_manager/orders_recieve_cash_state_manager.dart'
    as _i99;
import 'package:c4d/module_orders/state_manager/orders_without_distance_state_manager.dart'
    as _i96;
import 'package:c4d/module_orders/state_manager/recycle_order/recycle_order_state_manager.dart'
    as _i44;
import 'package:c4d/module_orders/state_manager/search_for_order_state_manager.dart'
    as _i46;
import 'package:c4d/module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i50;
import 'package:c4d/module_orders/ui/screens/new_order/new_order_link.dart'
    as _i170;
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart'
    as _i171;
import 'package:c4d/module_orders/ui/screens/new_order/update_order_screen.dart'
    as _i129;
import 'package:c4d/module_orders/ui/screens/order_actions_log_screen.dart'
    as _i173;
import 'package:c4d/module_orders/ui/screens/order_cash_captain_screen.dart'
    as _i97;
import 'package:c4d/module_orders/ui/screens/order_cash_store_screen.dart'
    as _i182;
import 'package:c4d/module_orders/ui/screens/order_conflict_distance_screen.dart'
    as _i176;
import 'package:c4d/module_orders/ui/screens/order_logs_screen.dart' as _i177;
import 'package:c4d/module_orders/ui/screens/order_pending_screen.dart'
    as _i179;
import 'package:c4d/module_orders/ui/screens/orders_captain_screen.dart'
    as _i174;
import 'package:c4d/module_orders/ui/screens/orders_receive_cash_screen.dart'
    as _i183;
import 'package:c4d/module_orders/ui/screens/orders_without_distance_screen.dart'
    as _i100;
import 'package:c4d/module_orders/ui/screens/recycle_order/recycle_order_screen.dart'
    as _i107;
import 'package:c4d/module_orders/ui/screens/search_for_order_screen.dart'
    as _i109;
import 'package:c4d/module_orders/ui/screens/sub_orders_screen.dart' as _i119;
import 'package:c4d/module_payments/manager/payments_manager.dart' as _i103;
import 'package:c4d/module_payments/payments_module.dart' as _i241;
import 'package:c4d/module_payments/repository/payments_repository.dart'
    as _i43;
import 'package:c4d/module_payments/service/payments_service.dart' as _i104;
import 'package:c4d/module_payments/state_manager/captain_daily_finance_state_manager.dart'
    as _i159;
import 'package:c4d/module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i140;
import 'package:c4d/module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i141;
import 'package:c4d/module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i142;
import 'package:c4d/module_payments/state_manager/payments_to_state_manager.dart'
    as _i105;
import 'package:c4d/module_payments/state_manager/store_balance_state_manager.dart'
    as _i115;
import 'package:c4d/module_payments/ui/screen/all_amount_captains_screen.dart'
    as _i209;
import 'package:c4d/module_payments/ui/screen/captain_finance_by_hours_screen.dart'
    as _i214;
import 'package:c4d/module_payments/ui/screen/captain_finance_by_order_count_screen.dart'
    as _i213;
import 'package:c4d/module_payments/ui/screen/captain_finance_by_order_screen.dart'
    as _i215;
import 'package:c4d/module_payments/ui/screen/daily_payments_screen.dart'
    as _i160;
import 'package:c4d/module_payments/ui/screen/payment_to_captain_screen.dart'
    as _i186;
import 'package:c4d/module_payments/ui/screen/store_balance_screen.dart'
    as _i190;
import 'package:c4d/module_settings/settings_module.dart' as _i188;
import 'package:c4d/module_settings/ui/settings_page/choose_local_page.dart'
    as _i21;
import 'package:c4d/module_settings/ui/settings_page/settings_page.dart'
    as _i110;
import 'package:c4d/module_splash/splash_module.dart' as _i111;
import 'package:c4d/module_splash/ui/screen/splash_screen.dart' as _i47;
import 'package:c4d/module_statistics/manager/statistic_manager.dart' as _i112;
import 'package:c4d/module_statistics/repository/statistics_repository.dart'
    as _i48;
import 'package:c4d/module_statistics/service/statistics_service.dart' as _i113;
import 'package:c4d/module_statistics/state_manager/statistics_state_manager.dart'
    as _i114;
import 'package:c4d/module_statistics/ui/screen/statistics_screen.dart'
    as _i189;
import 'package:c4d/module_statistics/ui/statistics_module.dart' as _i242;
import 'package:c4d/module_stores/hive/store_hive_helper.dart' as _i15;
import 'package:c4d/module_stores/manager/stores_manager.dart' as _i116;
import 'package:c4d/module_stores/repository/stores_repository.dart' as _i49;
import 'package:c4d/module_stores/service/store_service.dart' as _i117;
import 'package:c4d/module_stores/state_manager/order/filter_orders_top_active_state_manager.dart'
    as _i162;
import 'package:c4d/module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i175;
import 'package:c4d/module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i178;
import 'package:c4d/module_stores/state_manager/order/order_status.state_manager.dart'
    as _i180;
import 'package:c4d/module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i181;
import 'package:c4d/module_stores/state_manager/store_profile_state_manager.dart'
    as _i192;
import 'package:c4d/module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i197;
import 'package:c4d/module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i198;
import 'package:c4d/module_stores/state_manager/stores_state_manager.dart'
    as _i118;
import 'package:c4d/module_stores/state_manager/top_active_store.dart' as _i127;
import 'package:c4d/module_stores/stores_module.dart' as _i257;
import 'package:c4d/module_stores/ui/screen/order/order_captain_not_arrived.dart'
    as _i236;
import 'package:c4d/module_stores/ui/screen/order/order_details_screen.dart'
    as _i237;
import 'package:c4d/module_stores/ui/screen/order/order_logs_screen.dart'
    as _i238;
import 'package:c4d/module_stores/ui/screen/order/order_time_line_screen.dart'
    as _i239;
import 'package:c4d/module_stores/ui/screen/order/order_top_active_store.dart'
    as _i184;
import 'package:c4d/module_stores/ui/screen/store_info_screen.dart' as _i243;
import 'package:c4d/module_stores/ui/screen/stores_inactive_screen.dart'
    as _i246;
import 'package:c4d/module_stores/ui/screen/stores_needs_support_screen.dart'
    as _i247;
import 'package:c4d/module_stores/ui/screen/stores_screen.dart' as _i199;
import 'package:c4d/module_stores/ui/screen/top_active_store_screen.dart'
    as _i128;
import 'package:c4d/module_subscriptions/manager/subscriptions_manager.dart'
    as _i120;
import 'package:c4d/module_subscriptions/repository/subscriptions_repository.dart'
    as _i51;
import 'package:c4d/module_subscriptions/service/subscriptions_service.dart'
    as _i121;
import 'package:c4d/module_subscriptions/state_manager/edit_subscription_state_manager.dart'
    as _i161;
import 'package:c4d/module_subscriptions/state_manager/init_subscription_state_manager.dart'
    as _i167;
import 'package:c4d/module_subscriptions/state_manager/store_financial_subscriptions_details_state_manager.dart'
    as _i191;
import 'package:c4d/module_subscriptions/state_manager/store_subscription_management_state_manager.dart'
    as _i193;
import 'package:c4d/module_subscriptions/state_manager/store_subscriptions_expired_finance_state_manager.dart'
    as _i194;
import 'package:c4d/module_subscriptions/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i196;
import 'package:c4d/module_subscriptions/state_manager/subscription_to_captain_offer_state_manager.dart'
    as _i201;
import 'package:c4d/module_subscriptions/subscriptions_module.dart' as _i248;
import 'package:c4d/module_subscriptions/ui/screen/edit_subscription_screen.dart'
    as _i230;
import 'package:c4d/module_subscriptions/ui/screen/init_subscription_screen.dart'
    as _i228;
import 'package:c4d/module_subscriptions/ui/screen/store_subscriptions_details_screen.dart'
    as _i195;
import 'package:c4d/module_subscriptions/ui/screen/store_subscriptions_expired_screen.dart'
    as _i244;
import 'package:c4d/module_subscriptions/ui/screen/store_subscriptions_screen.dart'
    as _i245;
import 'package:c4d/module_subscriptions/ui/screen/subscription_to_captain_offer_screen.dart'
    as _i229;
import 'package:c4d/module_subscriptions/ui/screen/subscriptions_managment_screen.dart'
    as _i200;
import 'package:c4d/module_supplier/manager/supplier_manager.dart' as _i54;
import 'package:c4d/module_supplier/repository/supplier_repository.dart'
    as _i53;
import 'package:c4d/module_supplier/service/supplier_service.dart' as _i125;
import 'package:c4d/module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i165;
import 'package:c4d/module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i202;
import 'package:c4d/module_supplier/state_manager/supplier_list.dart' as _i126;
import 'package:c4d/module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i204;
import 'package:c4d/module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i205;
import 'package:c4d/module_supplier/supplier_module.dart' as _i258;
import 'package:c4d/module_supplier/ui/screen/in_active_supplier_screen.dart'
    as _i231;
import 'package:c4d/module_supplier/ui/screen/supplier_ads_screen.dart'
    as _i249;
import 'package:c4d/module_supplier/ui/screen/supplier_list_screen.dart'
    as _i206;
import 'package:c4d/module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i251;
import 'package:c4d/module_supplier/ui/screen/supplier_profile_screen.dart'
    as _i252;
import 'package:c4d/module_supplier_categories/categories_supplier_module.dart'
    as _i250;
import 'package:c4d/module_supplier_categories/manager/categories_manager.dart'
    as _i122;
import 'package:c4d/module_supplier_categories/repository/categories_repository.dart'
    as _i52;
import 'package:c4d/module_supplier_categories/service/supplier_categories_service.dart'
    as _i123;
import 'package:c4d/module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i124;
import 'package:c4d/module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i203;
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart'
    as _i16;
import 'package:c4d/module_theme/service/theme_service/theme_service.dart'
    as _i19;
import 'package:c4d/module_upload/manager/upload_manager/upload_manager.dart'
    as _i22;
import 'package:c4d/module_upload/repository/upload_repository/upload_repository.dart'
    as _i17;
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart'
    as _i35;
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
  gh.factory<_i15.StoresHiveHelper>(() => _i15.StoresHiveHelper());
  gh.factory<_i16.ThemePreferencesHelper>(() => _i16.ThemePreferencesHelper());
  gh.factory<_i17.UploadRepository>(() => _i17.UploadRepository());
  gh.factory<_i18.ApiClient>(() => _i18.ApiClient(gh<_i12.Logger>()));
  gh.factory<_i19.AppThemeDataService>(
      () => _i19.AppThemeDataService(gh<_i16.ThemePreferencesHelper>()));
  gh.factory<_i20.AuthRepository>(
      () => _i20.AuthRepository(gh<_i18.ApiClient>(), gh<_i12.Logger>()));
  gh.factory<_i21.ChooseLocalScreen>(
      () => _i21.ChooseLocalScreen(gh<_i11.LocalizationService>()));
  gh.factory<_i22.UploadManager>(
      () => _i22.UploadManager(gh<_i17.UploadRepository>()));
  gh.factory<_i23.AuthManager>(
      () => _i23.AuthManager(gh<_i20.AuthRepository>()));
  gh.factory<_i24.AuthService>(() =>
      _i24.AuthService(gh<_i4.AuthPrefsHelper>(), gh<_i23.AuthManager>()));
  gh.factory<_i25.BidOrderRepository>(() =>
      _i25.BidOrderRepository(gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i26.BranchesRepository>(() =>
      _i26.BranchesRepository(gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i27.CaptainsRepository>(() =>
      _i27.CaptainsRepository(gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i28.CarsRepository>(
      () => _i28.CarsRepository(gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i29.CategoriesRepository>(() =>
      _i29.CategoriesRepository(gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i30.ChatRepository>(
      () => _i30.ChatRepository(gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i31.CompanyRepository>(() =>
      _i31.CompanyRepository(gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i32.DeepLinkRepository>(() =>
      _i32.DeepLinkRepository(gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i33.ForgotPassStateManager>(
      () => _i33.ForgotPassStateManager(gh<_i24.AuthService>()));
  gh.factory<_i34.HomeRepository>(
      () => _i34.HomeRepository(gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i35.ImageUploadService>(
      () => _i35.ImageUploadService(gh<_i22.UploadManager>()));
  gh.factory<_i36.LoginStateManager>(
      () => _i36.LoginStateManager(gh<_i24.AuthService>()));
  gh.factory<_i37.MyNotificationsRepository>(() =>
      _i37.MyNotificationsRepository(
          gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i38.NoticeRepository>(() =>
      _i38.NoticeRepository(gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i39.NotificationRepo>(() =>
      _i39.NotificationRepo(gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i40.OrderRepository>(
      () => _i40.OrderRepository(gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i41.OrdersManager>(
      () => _i41.OrdersManager(gh<_i40.OrderRepository>()));
  gh.factory<_i42.OrdersService>(
      () => _i42.OrdersService(gh<_i41.OrdersManager>()));
  gh.factory<_i43.PaymentsRepository>(() =>
      _i43.PaymentsRepository(gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i44.RecycleOrderStateManager>(
      () => _i44.RecycleOrderStateManager(gh<_i42.OrdersService>()));
  gh.factory<_i45.RegisterStateManager>(
      () => _i45.RegisterStateManager(gh<_i24.AuthService>()));
  gh.factory<_i46.SearchForOrderStateManager>(
      () => _i46.SearchForOrderStateManager(gh<_i42.OrdersService>()));
  gh.factory<_i47.SplashScreen>(
      () => _i47.SplashScreen(gh<_i24.AuthService>()));
  gh.factory<_i48.StatisticsReposetory>(() =>
      _i48.StatisticsReposetory(gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i49.StoresRepository>(() =>
      _i49.StoresRepository(gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i50.SubOrdersStateManager>(() => _i50.SubOrdersStateManager(
      gh<_i42.OrdersService>(), gh<_i24.AuthService>()));
  gh.factory<_i51.SubscriptionsRepository>(() => _i51.SubscriptionsRepository(
      gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i52.SupplierCategoriesRepository>(() =>
      _i52.SupplierCategoriesRepository(
          gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i53.SupplierRepository>(() =>
      _i53.SupplierRepository(gh<_i18.ApiClient>(), gh<_i24.AuthService>()));
  gh.factory<_i54.SuppliersManager>(
      () => _i54.SuppliersManager(gh<_i53.SupplierRepository>()));
  gh.factory<_i55.UpdateOrderStateManager>(
      () => _i55.UpdateOrderStateManager(gh<_i42.OrdersService>()));
  gh.factory<_i56.BidOrderManager>(
      () => _i56.BidOrderManager(gh<_i25.BidOrderRepository>()));
  gh.factory<_i57.BidOrderService>(
      () => _i57.BidOrderService(gh<_i56.BidOrderManager>()));
  gh.factory<_i58.BidOrderStateManager>(
      () => _i58.BidOrderStateManager(gh<_i57.BidOrderService>()));
  gh.factory<_i59.BidOrdersScreen>(
      () => _i59.BidOrdersScreen(gh<_i58.BidOrderStateManager>()));
  gh.factory<_i60.BranchesManager>(
      () => _i60.BranchesManager(gh<_i26.BranchesRepository>()));
  gh.factory<_i61.CaptainsManager>(
      () => _i61.CaptainsManager(gh<_i27.CaptainsRepository>()));
  gh.factory<_i62.CaptainsService>(
      () => _i62.CaptainsService(gh<_i61.CaptainsManager>()));
  gh.factory<_i63.CaptainsStateManager>(
      () => _i63.CaptainsStateManager(gh<_i62.CaptainsService>()));
  gh.factory<_i64.CaptinRatingDetailsStateManager>(
      () => _i64.CaptinRatingDetailsStateManager(gh<_i62.CaptainsService>()));
  gh.factory<_i65.CarsManager>(
      () => _i65.CarsManager(gh<_i28.CarsRepository>()));
  gh.factory<_i66.CarsService>(() => _i66.CarsService(gh<_i65.CarsManager>()));
  gh.factory<_i67.CarsStateManager>(
      () => _i67.CarsStateManager(gh<_i66.CarsService>()));
  gh.factory<_i68.CategoriesManager>(
      () => _i68.CategoriesManager(gh<_i29.CategoriesRepository>()));
  gh.factory<_i69.CategoriesService>(
      () => _i69.CategoriesService(gh<_i68.CategoriesManager>()));
  gh.factory<_i70.ChatManager>(
      () => _i70.ChatManager(gh<_i30.ChatRepository>()));
  gh.factory<_i71.ChatService>(() => _i71.ChatService(gh<_i70.ChatManager>()));
  gh.factory<_i72.ChatStateManager>(
      () => _i72.ChatStateManager(gh<_i71.ChatService>()));
  gh.factory<_i73.CompanyManager>(
      () => _i73.CompanyManager(gh<_i31.CompanyRepository>()));
  gh.factory<_i74.CompanyService>(
      () => _i74.CompanyService(gh<_i73.CompanyManager>()));
  gh.factory<_i75.FireNotificationService>(() => _i75.FireNotificationService(
      gh<_i13.NotificationsPrefHelper>(), gh<_i39.NotificationRepo>()));
  gh.factory<_i76.ForgotPassScreen>(
      () => _i76.ForgotPassScreen(gh<_i33.ForgotPassStateManager>()));
  gh.factory<_i77.HomeManager>(
      () => _i77.HomeManager(gh<_i34.HomeRepository>()));
  gh.factory<_i78.HomeService>(() => _i78.HomeService(gh<_i77.HomeManager>()));
  gh.factory<_i79.HomeStateManager>(
      () => _i79.HomeStateManager(gh<_i78.HomeService>()));
  gh.factory<_i80.InActiveCaptainsStateManager>(
      () => _i80.InActiveCaptainsStateManager(gh<_i62.CaptainsService>()));
  gh.factory<_i81.LoginScreen>(
      () => _i81.LoginScreen(gh<_i36.LoginStateManager>()));
  gh.factory<_i82.MyNotificationsManager>(
      () => _i82.MyNotificationsManager(gh<_i37.MyNotificationsRepository>()));
  gh.factory<_i83.MyNotificationsService>(
      () => _i83.MyNotificationsService(gh<_i82.MyNotificationsManager>()));
  gh.factory<_i84.MyNotificationsStateManager>(() =>
      _i84.MyNotificationsStateManager(gh<_i83.MyNotificationsService>(),
          gh<_i42.OrdersService>(), gh<_i24.AuthService>()));
  gh.factory<_i85.NewOrderLinkStateManager>(
      () => _i85.NewOrderLinkStateManager(gh<_i42.OrdersService>()));
  gh.factory<_i86.NewOrderStateManager>(
      () => _i86.NewOrderStateManager(gh<_i42.OrdersService>()));
  gh.factory<_i87.NoticeManager>(
      () => _i87.NoticeManager(gh<_i38.NoticeRepository>()));
  gh.factory<_i88.NoticeService>(
      () => _i88.NoticeService(gh<_i87.NoticeManager>()));
  gh.factory<_i89.NoticeStateManager>(
      () => _i89.NoticeStateManager(gh<_i88.NoticeService>()));
  gh.factory<_i90.OrderActionLogsStateManager>(
      () => _i90.OrderActionLogsStateManager(gh<_i42.OrdersService>()));
  gh.factory<_i91.OrderCaptainLogsStateManager>(
      () => _i91.OrderCaptainLogsStateManager(gh<_i42.OrdersService>()));
  gh.factory<_i92.OrderCashCaptainStateManager>(
      () => _i92.OrderCashCaptainStateManager(gh<_i42.OrdersService>()));
  gh.factory<_i93.OrderDistanceConflictStateManager>(
      () => _i93.OrderDistanceConflictStateManager(gh<_i42.OrdersService>()));
  gh.factory<_i94.OrderLogsStateManager>(
      () => _i94.OrderLogsStateManager(gh<_i42.OrdersService>()));
  gh.factory<_i95.OrderPendingStateManager>(
      () => _i95.OrderPendingStateManager(gh<_i42.OrdersService>()));
  gh.factory<_i96.OrderWithoutDistanceStateManager>(
      () => _i96.OrderWithoutDistanceStateManager(gh<_i42.OrdersService>()));
  gh.factory<_i97.OrdersCashCaptainScreen>(() =>
      _i97.OrdersCashCaptainScreen(gh<_i92.OrderCashCaptainStateManager>()));
  gh.factory<_i98.OrdersCashStoreStateManager>(
      () => _i98.OrdersCashStoreStateManager(gh<_i42.OrdersService>()));
  gh.factory<_i99.OrdersReceiveCashStateManager>(
      () => _i99.OrdersReceiveCashStateManager(gh<_i42.OrdersService>()));
  gh.factory<_i100.OrdersWithoutDistanceScreen>(() =>
      _i100.OrdersWithoutDistanceScreen(
          gh<_i96.OrderWithoutDistanceStateManager>()));
  gh.factory<_i101.PackageCategoriesStateManager>(() =>
      _i101.PackageCategoriesStateManager(
          gh<_i69.CategoriesService>(), gh<_i35.ImageUploadService>()));
  gh.factory<_i102.PackagesStateManager>(() => _i102.PackagesStateManager(
      gh<_i69.CategoriesService>(), gh<_i24.AuthService>()));
  gh.factory<_i103.PaymentsManager>(
      () => _i103.PaymentsManager(gh<_i43.PaymentsRepository>()));
  gh.factory<_i104.PaymentsService>(
      () => _i104.PaymentsService(gh<_i103.PaymentsManager>()));
  gh.factory<_i105.PaymentsToCaptainStateManager>(
      () => _i105.PaymentsToCaptainStateManager(gh<_i104.PaymentsService>()));
  gh.factory<_i106.PlanScreenStateManager>(
      () => _i106.PlanScreenStateManager(gh<_i104.PaymentsService>()));
  gh.factory<_i107.RecycleOrderScreen>(
      () => _i107.RecycleOrderScreen(gh<_i44.RecycleOrderStateManager>()));
  gh.factory<_i108.RegisterScreen>(
      () => _i108.RegisterScreen(gh<_i45.RegisterStateManager>()));
  gh.factory<_i109.SearchForOrderScreen>(
      () => _i109.SearchForOrderScreen(gh<_i46.SearchForOrderStateManager>()));
  gh.factory<_i110.SettingsScreen>(() => _i110.SettingsScreen(
      gh<_i24.AuthService>(),
      gh<_i11.LocalizationService>(),
      gh<_i19.AppThemeDataService>(),
      gh<_i75.FireNotificationService>()));
  gh.factory<_i111.SplashModule>(
      () => _i111.SplashModule(gh<_i47.SplashScreen>()));
  gh.factory<_i112.StatisticManager>(
      () => _i112.StatisticManager(gh<_i48.StatisticsReposetory>()));
  gh.factory<_i113.StatisticsServiec>(
      () => _i113.StatisticsServiec(gh<_i112.StatisticManager>()));
  gh.factory<_i114.StatisticsStateManager>(
      () => _i114.StatisticsStateManager(gh<_i113.StatisticsServiec>()));
  gh.factory<_i115.StoreBalanceStateManager>(
      () => _i115.StoreBalanceStateManager(gh<_i104.PaymentsService>()));
  gh.factory<_i116.StoreManager>(
      () => _i116.StoreManager(gh<_i49.StoresRepository>()));
  gh.factory<_i117.StoresService>(() =>
      _i117.StoresService(gh<_i116.StoreManager>(), gh<_i41.OrdersManager>()));
  gh.factory<_i118.StoresStateManager>(() => _i118.StoresStateManager(
      gh<_i117.StoresService>(),
      gh<_i24.AuthService>(),
      gh<_i35.ImageUploadService>()));
  gh.factory<_i119.SubOrdersScreen>(
      () => _i119.SubOrdersScreen(gh<_i50.SubOrdersStateManager>()));
  gh.factory<_i120.SubscriptionsManager>(
      () => _i120.SubscriptionsManager(gh<_i51.SubscriptionsRepository>()));
  gh.factory<_i121.SubscriptionsService>(
      () => _i121.SubscriptionsService(gh<_i120.SubscriptionsManager>()));
  gh.factory<_i122.SupplierCategoriesManager>(() =>
      _i122.SupplierCategoriesManager(gh<_i52.SupplierCategoriesRepository>()));
  gh.factory<_i123.SupplierCategoriesService>(() =>
      _i123.SupplierCategoriesService(gh<_i122.SupplierCategoriesManager>()));
  gh.factory<_i124.SupplierCategoriesStateManager>(() =>
      _i124.SupplierCategoriesStateManager(
          gh<_i123.SupplierCategoriesService>(),
          gh<_i35.ImageUploadService>()));
  gh.factory<_i125.SupplierService>(
      () => _i125.SupplierService(gh<_i54.SuppliersManager>()));
  gh.factory<_i126.SuppliersStateManager>(
      () => _i126.SuppliersStateManager(gh<_i125.SupplierService>()));
  gh.factory<_i127.TopActiveStateManagment>(
      () => _i127.TopActiveStateManagment(gh<_i117.StoresService>()));
  gh.factory<_i128.TopActiveStoreScreen>(
      () => _i128.TopActiveStoreScreen(gh<_i127.TopActiveStateManagment>()));
  gh.factory<_i129.UpdateOrderScreen>(
      () => _i129.UpdateOrderScreen(gh<_i55.UpdateOrderStateManager>()));
  gh.factory<_i130.UpdatesStateManager>(() => _i130.UpdatesStateManager(
      gh<_i83.MyNotificationsService>(), gh<_i24.AuthService>()));
  gh.factory<_i131.AccountBalanceStateManager>(
      () => _i131.AccountBalanceStateManager(gh<_i62.CaptainsService>()));
  gh.factory<_i132.AuthorizationModule>(() => _i132.AuthorizationModule(
      gh<_i81.LoginScreen>(),
      gh<_i108.RegisterScreen>(),
      gh<_i76.ForgotPassScreen>()));
  gh.factory<_i133.BidOrderDetailsScreen>(
      () => _i133.BidOrderDetailsScreen(gh<_i58.BidOrderStateManager>()));
  gh.factory<_i134.BidOrderModule>(
      () => _i134.BidOrderModule(gh<_i59.BidOrdersScreen>()));
  gh.factory<_i135.BranchesListService>(
      () => _i135.BranchesListService(gh<_i60.BranchesManager>()));
  gh.factory<_i136.BranchesListStateManager>(
      () => _i136.BranchesListStateManager(gh<_i135.BranchesListService>()));
  gh.factory<_i137.CaptainAccountBalanceScreen>(() =>
      _i137.CaptainAccountBalanceScreen(
          gh<_i131.AccountBalanceStateManager>()));
  gh.factory<_i138.CaptainActivityDetailsStateManager>(() =>
      _i138.CaptainActivityDetailsStateManager(gh<_i62.CaptainsService>()));
  gh.factory<_i139.CaptainAssignOrderStateManager>(
      () => _i139.CaptainAssignOrderStateManager(gh<_i62.CaptainsService>()));
  gh.factory<_i140.CaptainFinanceByHoursStateManager>(() =>
      _i140.CaptainFinanceByHoursStateManager(gh<_i104.PaymentsService>()));
  gh.factory<_i141.CaptainFinanceByOrderCountStateManager>(() =>
      _i141.CaptainFinanceByOrderCountStateManager(
          gh<_i104.PaymentsService>()));
  gh.factory<_i142.CaptainFinanceByOrderStateManager>(() =>
      _i142.CaptainFinanceByOrderStateManager(gh<_i104.PaymentsService>()));
  gh.factory<_i143.CaptainFinanceDailyStateManager>(
      () => _i143.CaptainFinanceDailyStateManager(gh<_i62.CaptainsService>()));
  gh.factory<_i144.CaptainFinancialDuesDetailsStateManager>(() =>
      _i144.CaptainFinancialDuesDetailsStateManager(
          gh<_i104.PaymentsService>(), gh<_i62.CaptainsService>()));
  gh.factory<_i145.CaptainFinancialDuesStateManager>(
      () => _i145.CaptainFinancialDuesStateManager(gh<_i62.CaptainsService>()));
  gh.factory<_i146.CaptainOfferStateManager>(() =>
      _i146.CaptainOfferStateManager(
          gh<_i62.CaptainsService>(), gh<_i35.ImageUploadService>()));
  gh.factory<_i147.CaptainOffersScreen>(
      () => _i147.CaptainOffersScreen(gh<_i146.CaptainOfferStateManager>()));
  gh.factory<_i148.CaptainProfileStateManager>(
      () => _i148.CaptainProfileStateManager(gh<_i62.CaptainsService>()));
  gh.factory<_i149.CaptainsActivityStateManager>(
      () => _i149.CaptainsActivityStateManager(gh<_i62.CaptainsService>()));
  gh.factory<_i150.CaptainsNeedsSupportStateManager>(
      () => _i150.CaptainsNeedsSupportStateManager(gh<_i62.CaptainsService>()));
  gh.factory<_i151.CaptainsRatingStateManager>(
      () => _i151.CaptainsRatingStateManager(gh<_i62.CaptainsService>()));
  gh.factory<_i152.CaptainsScreen>(
      () => _i152.CaptainsScreen(gh<_i63.CaptainsStateManager>()));
  gh.factory<_i153.CaptinRatingDetailsScreen>(() =>
      _i153.CaptinRatingDetailsScreen(
          gh<_i64.CaptinRatingDetailsStateManager>()));
  gh.factory<_i154.CarsScreen>(
      () => _i154.CarsScreen(gh<_i67.CarsStateManager>()));
  gh.factory<_i155.CategoriesScreen>(
      () => _i155.CategoriesScreen(gh<_i101.PackageCategoriesStateManager>()));
  gh.factory<_i156.ChatPage>(() => _i156.ChatPage(
      gh<_i72.ChatStateManager>(),
      gh<_i35.ImageUploadService>(),
      gh<_i24.AuthService>(),
      gh<_i6.ChatHiveHelper>()));
  gh.factory<_i157.CompanyFinanceStateManager>(() =>
      _i157.CompanyFinanceStateManager(
          gh<_i24.AuthService>(), gh<_i74.CompanyService>()));
  gh.factory<_i158.CompanyProfileStateManager>(() =>
      _i158.CompanyProfileStateManager(
          gh<_i24.AuthService>(), gh<_i74.CompanyService>()));
  gh.factory<_i159.DailyBalanceStateManager>(() =>
      _i159.DailyBalanceStateManager(gh<_i104.PaymentsService>(),
          gh<_i24.AuthService>(), gh<_i35.ImageUploadService>()));
  gh.factory<_i160.DailyPaymentsScreen>(
      () => _i160.DailyPaymentsScreen(gh<_i159.DailyBalanceStateManager>()));
  gh.factory<_i161.EditSubscriptionStateManager>(() =>
      _i161.EditSubscriptionStateManager(gh<_i121.SubscriptionsService>()));
  gh.factory<_i162.FilterOrderTopStateManager>(
      () => _i162.FilterOrderTopStateManager(gh<_i117.StoresService>()));
  gh.factory<_i163.HomeScreen>(
      () => _i163.HomeScreen(gh<_i79.HomeStateManager>()));
  gh.factory<_i164.InActiveCaptainsScreen>(() =>
      _i164.InActiveCaptainsScreen(gh<_i80.InActiveCaptainsStateManager>()));
  gh.factory<_i165.InActiveSupplierStateManager>(
      () => _i165.InActiveSupplierStateManager(gh<_i125.SupplierService>()));
  gh.factory<_i166.InitBranchesStateManager>(
      () => _i166.InitBranchesStateManager(gh<_i135.BranchesListService>()));
  gh.factory<_i167.InitSubscriptionStateManager>(() =>
      _i167.InitSubscriptionStateManager(gh<_i121.SubscriptionsService>()));
  gh.factory<_i168.MainScreen>(() => _i168.MainScreen(gh<_i163.HomeScreen>()));
  gh.factory<_i169.MyNotificationsScreen>(() =>
      _i169.MyNotificationsScreen(gh<_i84.MyNotificationsStateManager>()));
  gh.factory<_i170.NewOrderLinkScreen>(
      () => _i170.NewOrderLinkScreen(gh<_i85.NewOrderLinkStateManager>()));
  gh.factory<_i171.NewOrderScreen>(
      () => _i171.NewOrderScreen(gh<_i86.NewOrderStateManager>()));
  gh.factory<_i172.NoticeScreen>(
      () => _i172.NoticeScreen(gh<_i89.NoticeStateManager>()));
  gh.factory<_i173.OrderActionLogsScreen>(() =>
      _i173.OrderActionLogsScreen(gh<_i90.OrderActionLogsStateManager>()));
  gh.factory<_i174.OrderCaptainLogsScreen>(() =>
      _i174.OrderCaptainLogsScreen(gh<_i91.OrderCaptainLogsStateManager>()));
  gh.factory<_i175.OrderCaptainNotArrivedStateManager>(() =>
      _i175.OrderCaptainNotArrivedStateManager(gh<_i117.StoresService>()));
  gh.factory<_i176.OrderDistanceConflictScreen>(() =>
      _i176.OrderDistanceConflictScreen(
          gh<_i93.OrderDistanceConflictStateManager>()));
  gh.factory<_i177.OrderLogsScreen>(
      () => _i177.OrderLogsScreen(gh<_i94.OrderLogsStateManager>()));
  gh.factory<_i178.OrderLogsStateManager>(
      () => _i178.OrderLogsStateManager(gh<_i117.StoresService>()));
  gh.factory<_i179.OrderPendingScreen>(
      () => _i179.OrderPendingScreen(gh<_i95.OrderPendingStateManager>()));
  gh.factory<_i180.OrderStatusStateManager>(() => _i180.OrderStatusStateManager(
      gh<_i117.StoresService>(), gh<_i24.AuthService>()));
  gh.factory<_i181.OrderTimeLineStateManager>(() =>
      _i181.OrderTimeLineStateManager(
          gh<_i117.StoresService>(), gh<_i24.AuthService>()));
  gh.factory<_i182.OrdersCashStoreScreen>(() =>
      _i182.OrdersCashStoreScreen(gh<_i98.OrdersCashStoreStateManager>()));
  gh.factory<_i183.OrdersReceiveCashScreen>(() =>
      _i183.OrdersReceiveCashScreen(gh<_i99.OrdersReceiveCashStateManager>()));
  gh.factory<_i184.OrdersTopActiveStoreScreen>(() =>
      _i184.OrdersTopActiveStoreScreen(gh<_i162.FilterOrderTopStateManager>()));
  gh.factory<_i185.PackagesScreen>(
      () => _i185.PackagesScreen(gh<_i102.PackagesStateManager>()));
  gh.factory<_i186.PaymentsToCaptainScreen>(() =>
      _i186.PaymentsToCaptainScreen(gh<_i105.PaymentsToCaptainStateManager>()));
  gh.factory<_i187.PlanScreen>(
      () => _i187.PlanScreen(gh<_i106.PlanScreenStateManager>()));
  gh.factory<_i188.SettingsModule>(() => _i188.SettingsModule(
      gh<_i110.SettingsScreen>(), gh<_i21.ChooseLocalScreen>()));
  gh.factory<_i189.StatisticsScreen>(
      () => _i189.StatisticsScreen(gh<_i114.StatisticsStateManager>()));
  gh.factory<_i190.StoreBalanceScreen>(
      () => _i190.StoreBalanceScreen(gh<_i115.StoreBalanceStateManager>()));
  gh.factory<_i191.StoreFinancialSubscriptionsDuesDetailsStateManager>(() =>
      _i191.StoreFinancialSubscriptionsDuesDetailsStateManager(
          gh<_i104.PaymentsService>(), gh<_i121.SubscriptionsService>()));
  gh.factory<_i192.StoreProfileStateManager>(() =>
      _i192.StoreProfileStateManager(
          gh<_i117.StoresService>(), gh<_i35.ImageUploadService>()));
  gh.factory<_i193.StoreSubscriptionManagementStateManager>(() =>
      _i193.StoreSubscriptionManagementStateManager(
          gh<_i121.SubscriptionsService>()));
  gh.factory<_i194.StoreSubscriptionsExpiredFinanceStateManager>(() =>
      _i194.StoreSubscriptionsExpiredFinanceStateManager(
          gh<_i121.SubscriptionsService>()));
  gh.factory<_i195.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i195.StoreSubscriptionsFinanceDetailsScreen(
          gh<_i191.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i196.StoreSubscriptionsFinanceStateManager>(() =>
      _i196.StoreSubscriptionsFinanceStateManager(
          gh<_i121.SubscriptionsService>()));
  gh.factory<_i197.StoresInActiveStateManager>(() =>
      _i197.StoresInActiveStateManager(gh<_i117.StoresService>(),
          gh<_i24.AuthService>(), gh<_i35.ImageUploadService>()));
  gh.factory<_i198.StoresNeedsSupportStateManager>(
      () => _i198.StoresNeedsSupportStateManager(gh<_i117.StoresService>()));
  gh.factory<_i199.StoresScreen>(
      () => _i199.StoresScreen(gh<_i118.StoresStateManager>()));
  gh.factory<_i200.SubscriptionManagementScreen>(() =>
      _i200.SubscriptionManagementScreen(
          gh<_i193.StoreSubscriptionManagementStateManager>()));
  gh.factory<_i201.SubscriptionToCaptainOfferStateManager>(() =>
      _i201.SubscriptionToCaptainOfferStateManager(
          gh<_i121.SubscriptionsService>()));
  gh.factory<_i202.SupplierAdsStateManager>(
      () => _i202.SupplierAdsStateManager(gh<_i125.SupplierService>()));
  gh.factory<_i203.SupplierCategoriesScreen>(() =>
      _i203.SupplierCategoriesScreen(
          gh<_i124.SupplierCategoriesStateManager>()));
  gh.factory<_i204.SupplierNeedsSupportStateManager>(() =>
      _i204.SupplierNeedsSupportStateManager(gh<_i125.SupplierService>()));
  gh.factory<_i205.SupplierProfileStateManager>(
      () => _i205.SupplierProfileStateManager(gh<_i125.SupplierService>()));
  gh.factory<_i206.SuppliersScreen>(
      () => _i206.SuppliersScreen(gh<_i126.SuppliersStateManager>()));
  gh.factory<_i207.UpdateBranchStateManager>(
      () => _i207.UpdateBranchStateManager(gh<_i135.BranchesListService>()));
  gh.factory<_i208.UpdateScreen>(
      () => _i208.UpdateScreen(gh<_i130.UpdatesStateManager>()));
  gh.factory<_i209.AllAmountCaptainsScreen>(() =>
      _i209.AllAmountCaptainsScreen(gh<_i159.DailyBalanceStateManager>()));
  gh.factory<_i210.BranchesListScreen>(
      () => _i210.BranchesListScreen(gh<_i136.BranchesListStateManager>()));
  gh.factory<_i211.CaptainActivityDetailsScreen>(() =>
      _i211.CaptainActivityDetailsScreen(
          gh<_i138.CaptainActivityDetailsStateManager>()));
  gh.factory<_i212.CaptainAssignOrderScreen>(() =>
      _i212.CaptainAssignOrderScreen(
          gh<_i139.CaptainAssignOrderStateManager>()));
  gh.factory<_i213.CaptainFinanceByCountOrderScreen>(() =>
      _i213.CaptainFinanceByCountOrderScreen(
          gh<_i141.CaptainFinanceByOrderCountStateManager>()));
  gh.factory<_i214.CaptainFinanceByHoursScreen>(() =>
      _i214.CaptainFinanceByHoursScreen(
          gh<_i140.CaptainFinanceByHoursStateManager>()));
  gh.factory<_i215.CaptainFinanceByOrderScreen>(() =>
      _i215.CaptainFinanceByOrderScreen(
          gh<_i142.CaptainFinanceByOrderStateManager>()));
  gh.factory<_i216.CaptainFinanceDailyScreen>(() =>
      _i216.CaptainFinanceDailyScreen(
          gh<_i143.CaptainFinanceDailyStateManager>()));
  gh.factory<_i217.CaptainFinancialDuesDetailsScreen>(() =>
      _i217.CaptainFinancialDuesDetailsScreen(
          gh<_i144.CaptainFinancialDuesDetailsStateManager>()));
  gh.factory<_i218.CaptainFinancialDuesScreen>(() =>
      _i218.CaptainFinancialDuesScreen(
          gh<_i145.CaptainFinancialDuesStateManager>()));
  gh.factory<_i219.CaptainProfileScreen>(
      () => _i219.CaptainProfileScreen(gh<_i148.CaptainProfileStateManager>()));
  gh.factory<_i220.CaptainsActivityScreen>(() =>
      _i220.CaptainsActivityScreen(gh<_i149.CaptainsActivityStateManager>()));
  gh.factory<_i221.CaptainsNeedsSupportScreen>(() =>
      _i221.CaptainsNeedsSupportScreen(
          gh<_i150.CaptainsNeedsSupportStateManager>()));
  gh.factory<_i222.CaptainsRatingScreen>(
      () => _i222.CaptainsRatingScreen(gh<_i151.CaptainsRatingStateManager>()));
  gh.factory<_i223.CarsModule>(() => _i223.CarsModule(gh<_i154.CarsScreen>()));
  gh.factory<_i224.CategoriesModule>(() => _i224.CategoriesModule(
      gh<_i155.CategoriesScreen>(), gh<_i185.PackagesScreen>()));
  gh.factory<_i225.ChatModule>(
      () => _i225.ChatModule(gh<_i156.ChatPage>(), gh<_i24.AuthService>()));
  gh.factory<_i226.CompanyFinanceScreen>(
      () => _i226.CompanyFinanceScreen(gh<_i157.CompanyFinanceStateManager>()));
  gh.factory<_i227.CompanyProfileScreen>(
      () => _i227.CompanyProfileScreen(gh<_i158.CompanyProfileStateManager>()));
  gh.factory<_i228.CreateSubscriptionScreen>(() =>
      _i228.CreateSubscriptionScreen(gh<_i167.InitSubscriptionStateManager>()));
  gh.factory<_i229.CreateSubscriptionToCaptainOfferScreen>(() =>
      _i229.CreateSubscriptionToCaptainOfferScreen(
          gh<_i201.SubscriptionToCaptainOfferStateManager>()));
  gh.factory<_i230.EditSubscriptionScreen>(() =>
      _i230.EditSubscriptionScreen(gh<_i161.EditSubscriptionStateManager>()));
  gh.factory<_i231.InActiveSupplierScreen>(() =>
      _i231.InActiveSupplierScreen(gh<_i165.InActiveSupplierStateManager>()));
  gh.factory<_i232.InitBranchesScreen>(
      () => _i232.InitBranchesScreen(gh<_i166.InitBranchesStateManager>()));
  gh.factory<_i233.MainModule>(
      () => _i233.MainModule(gh<_i168.MainScreen>(), gh<_i163.HomeScreen>()));
  gh.factory<_i234.MyNotificationsModule>(() => _i234.MyNotificationsModule(
      gh<_i169.MyNotificationsScreen>(), gh<_i208.UpdateScreen>()));
  gh.factory<_i235.NoticeModule>(
      () => _i235.NoticeModule(gh<_i172.NoticeScreen>()));
  gh.factory<_i236.OrderCaptainNotArrivedScreen>(() =>
      _i236.OrderCaptainNotArrivedScreen(
          gh<_i175.OrderCaptainNotArrivedStateManager>()));
  gh.factory<_i237.OrderDetailsScreen>(
      () => _i237.OrderDetailsScreen(gh<_i180.OrderStatusStateManager>()));
  gh.factory<_i238.OrderLogsScreen>(
      () => _i238.OrderLogsScreen(gh<_i178.OrderLogsStateManager>()));
  gh.factory<_i239.OrderTimeLineScreen>(
      () => _i239.OrderTimeLineScreen(gh<_i181.OrderTimeLineStateManager>()));
  gh.factory<_i240.OrdersModule>(() => _i240.OrdersModule(
      gh<_i177.OrderLogsScreen>(),
      gh<_i97.OrdersCashCaptainScreen>(),
      gh<_i182.OrdersCashStoreScreen>(),
      gh<_i129.UpdateOrderScreen>(),
      gh<_i179.OrderPendingScreen>(),
      gh<_i171.NewOrderScreen>(),
      gh<_i174.OrderCaptainLogsScreen>(),
      gh<_i173.OrderActionLogsScreen>(),
      gh<_i100.OrdersWithoutDistanceScreen>(),
      gh<_i183.OrdersReceiveCashScreen>(),
      gh<_i119.SubOrdersScreen>(),
      gh<_i170.NewOrderLinkScreen>(),
      gh<_i109.SearchForOrderScreen>(),
      gh<_i107.RecycleOrderScreen>(),
      gh<_i176.OrderDistanceConflictScreen>()));
  gh.factory<_i241.PaymentsModule>(() => _i241.PaymentsModule(
      gh<_i213.CaptainFinanceByCountOrderScreen>(),
      gh<_i214.CaptainFinanceByHoursScreen>(),
      gh<_i215.CaptainFinanceByOrderScreen>(),
      gh<_i186.PaymentsToCaptainScreen>(),
      gh<_i190.StoreBalanceScreen>(),
      gh<_i160.DailyPaymentsScreen>(),
      gh<_i209.AllAmountCaptainsScreen>()));
  gh.factory<_i242.StatisticsModule>(
      () => _i242.StatisticsModule(gh<_i189.StatisticsScreen>()));
  gh.factory<_i243.StoreInfoScreen>(
      () => _i243.StoreInfoScreen(gh<_i192.StoreProfileStateManager>()));
  gh.factory<_i244.StoreSubscriptionsExpiredFinanceScreen>(() =>
      _i244.StoreSubscriptionsExpiredFinanceScreen(
          gh<_i194.StoreSubscriptionsExpiredFinanceStateManager>()));
  gh.factory<_i245.StoreSubscriptionsFinanceScreen>(() =>
      _i245.StoreSubscriptionsFinanceScreen(
          gh<_i196.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i246.StoresInActiveScreen>(
      () => _i246.StoresInActiveScreen(gh<_i197.StoresInActiveStateManager>()));
  gh.factory<_i247.StoresNeedsSupportScreen>(() =>
      _i247.StoresNeedsSupportScreen(
          gh<_i198.StoresNeedsSupportStateManager>()));
  gh.factory<_i248.SubscriptionsModule>(() => _i248.SubscriptionsModule(
      gh<_i195.StoreSubscriptionsFinanceDetailsScreen>(),
      gh<_i245.StoreSubscriptionsFinanceScreen>(),
      gh<_i200.SubscriptionManagementScreen>(),
      gh<_i244.StoreSubscriptionsExpiredFinanceScreen>(),
      gh<_i228.CreateSubscriptionScreen>(),
      gh<_i229.CreateSubscriptionToCaptainOfferScreen>(),
      gh<_i230.EditSubscriptionScreen>()));
  gh.factory<_i249.SupplierAdsScreen>(
      () => _i249.SupplierAdsScreen(gh<_i202.SupplierAdsStateManager>()));
  gh.factory<_i250.SupplierCategoriesModule>(() =>
      _i250.SupplierCategoriesModule(gh<_i203.SupplierCategoriesScreen>()));
  gh.factory<_i251.SupplierNeedsSupportScreen>(() =>
      _i251.SupplierNeedsSupportScreen(
          gh<_i204.SupplierNeedsSupportStateManager>()));
  gh.factory<_i252.SupplierProfileScreen>(() =>
      _i252.SupplierProfileScreen(gh<_i205.SupplierProfileStateManager>()));
  gh.factory<_i253.UpdateBranchScreen>(
      () => _i253.UpdateBranchScreen(gh<_i207.UpdateBranchStateManager>()));
  gh.factory<_i254.BranchesModule>(() => _i254.BranchesModule(
      gh<_i210.BranchesListScreen>(),
      gh<_i253.UpdateBranchScreen>(),
      gh<_i232.InitBranchesScreen>()));
  gh.factory<_i255.CaptainsModule>(() => _i255.CaptainsModule(
      gh<_i147.CaptainOffersScreen>(),
      gh<_i164.InActiveCaptainsScreen>(),
      gh<_i152.CaptainsScreen>(),
      gh<_i219.CaptainProfileScreen>(),
      gh<_i221.CaptainsNeedsSupportScreen>(),
      gh<_i137.CaptainAccountBalanceScreen>(),
      gh<_i217.CaptainFinancialDuesDetailsScreen>(),
      gh<_i218.CaptainFinancialDuesScreen>(),
      gh<_i187.PlanScreen>(),
      gh<_i212.CaptainAssignOrderScreen>(),
      gh<_i222.CaptainsRatingScreen>(),
      gh<_i153.CaptinRatingDetailsScreen>(),
      gh<_i220.CaptainsActivityScreen>(),
      gh<_i211.CaptainActivityDetailsScreen>(),
      gh<_i216.CaptainFinanceDailyScreen>()));
  gh.factory<_i256.CompanyModule>(() => _i256.CompanyModule(
      gh<_i227.CompanyProfileScreen>(), gh<_i226.CompanyFinanceScreen>()));
  gh.factory<_i257.StoresModule>(() => _i257.StoresModule(
      gh<_i199.StoresScreen>(),
      gh<_i243.StoreInfoScreen>(),
      gh<_i246.StoresInActiveScreen>(),
      gh<_i190.StoreBalanceScreen>(),
      gh<_i247.StoresNeedsSupportScreen>(),
      gh<_i237.OrderDetailsScreen>(),
      gh<_i238.OrderLogsScreen>(),
      gh<_i236.OrderCaptainNotArrivedScreen>(),
      gh<_i239.OrderTimeLineScreen>(),
      gh<_i128.TopActiveStoreScreen>(),
      gh<_i184.OrdersTopActiveStoreScreen>()));
  gh.factory<_i258.SupplierModule>(() => _i258.SupplierModule(
      gh<_i231.InActiveSupplierScreen>(),
      gh<_i206.SuppliersScreen>(),
      gh<_i252.SupplierProfileScreen>(),
      gh<_i251.SupplierNeedsSupportScreen>(),
      gh<_i249.SupplierAdsScreen>()));
  gh.factory<_i259.MyApp>(() => _i259.MyApp(
      gh<_i19.AppThemeDataService>(),
      gh<_i11.LocalizationService>(),
      gh<_i75.FireNotificationService>(),
      gh<_i9.LocalNotificationService>(),
      gh<_i111.SplashModule>(),
      gh<_i132.AuthorizationModule>(),
      gh<_i225.ChatModule>(),
      gh<_i188.SettingsModule>(),
      gh<_i233.MainModule>(),
      gh<_i257.StoresModule>(),
      gh<_i224.CategoriesModule>(),
      gh<_i256.CompanyModule>(),
      gh<_i254.BranchesModule>(),
      gh<_i235.NoticeModule>(),
      gh<_i255.CaptainsModule>(),
      gh<_i241.PaymentsModule>(),
      gh<_i250.SupplierCategoriesModule>(),
      gh<_i258.SupplierModule>(),
      gh<_i223.CarsModule>(),
      gh<_i134.BidOrderModule>(),
      gh<_i240.OrdersModule>(),
      gh<_i248.SubscriptionsModule>(),
      gh<_i234.MyNotificationsModule>(),
      gh<_i242.StatisticsModule>()));
  return getIt;
}
