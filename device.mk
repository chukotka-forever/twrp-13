#
# Copyright (C) 2021 The TWRP Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := device/realme/RMX3461

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Enable virtual A/B OTA
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Configure SDCard replacement functionality
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# API
PRODUCT_TARGET_VNDK_VERSION := 30
PRODUCT_SHIPPING_API_LEVEL := 31

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# A/B
ENABLE_VIRTUAL_AB := true
BOARD_USES_RECOVERY_AS_BOOT := true
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    system \
    system_ext \
    product \
    vendor \
    vendor_boot \
    odm \
    vbmeta \
    vbmeta_system \

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Boot control HAL
PRODUCT_PACKAGES += \
    bootctrl.lahaina.recovery \
    android.hardware.boot@1.1-impl-qti.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl
    
PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

#  Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl.recovery \
    android.hardware.health@2.1-service

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd
    
# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/qcom-caf/bootctrl \
    vendor/qcom/opensource/commonsys-intf/display

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
BOARD_USES_QCOM_FBE_DECRYPTION := true

TW_LOAD_VENDOR_MODULES := "adsp_loader_dlkm.ko apr_dlkm.ko aw882xx_dlkm.ko aw8697.ko bolero_cdc_dlkm.ko bt_fm_slim.ko btpower.ko camera.ko e4000.ko explorer.ko fc0011.ko fc0012.ko fc0013.ko fc2580.ko haptic.ko haptic_feedback.ko hdmi_dlkm.ko hid-aksys.ko horae_shell_temp.ko it913x.ko last_boot_reason.ko llcc_perfmon.ko m88rs6000t.ko machine_dlkm.ko max2165.ko mbhc_dlkm.ko mc44s803.ko modules.alias modules.blocklist modules.dep modules.load modules.softdep msi001.ko msm_drm.ko mt20xx.ko mt2060.ko mt2063.ko mt2131.ko mt2266.ko mxl301rf.ko mxl5005s.ko mxl5007t.ko native_dlkm.ko oplus_bsp_ir_core.ko oplus_bsp_kookong_ir_spi.ko oplus_connectivity_routerboost.ko pinctrl_lpi_dlkm.ko pinctrl_wcd_dlkm.ko platform_dlkm.ko q6_dlkm.ko q6_notifier_dlkm.ko q6_pdr_dlkm.ko qca_cld3_qca6390.ko qca_cld3_qca6750.ko qca_cld3_wlan.ko qcom_edac.ko qm1d1b0004.ko qm1d1c0042.ko qt1010.ko r820t.ko radio-i2c-rtc6226-qca.ko rdbg.ko rmnet_core.ko rmnet_ctl.ko rmnet_offload.ko rmnet_shs.ko rx_macro_dlkm.ko si2157.ko sia81xx_dlkm.ko slimbus.ko slimbus-ngd.ko snd_event_dlkm.ko stub_dlkm.ko swr_ctrl_dlkm.ko swr_dlkm.ko swr_dmic_dlkm.ko swr_haptics_dlkm.ko tda9887.ko tda18212.ko tda18218.ko tda18250.ko tea5761.ko tea5767.ko tfa98xx-v6_dlkm.ko tua9001.ko tuner-simple.ko tuner-types.ko tuner-xc2028.ko tx_macro_dlkm.ko uff_fp_driver.ko va_macro_dlkm.ko wcd_core_dlkm.ko wcd9xxx_dlkm.ko wcd937x_dlkm.ko wcd937x_slave_dlkm.ko wcd938x_dlkm.ko wcd938x_slave_dlkm.ko wsa_macro_dlkm.ko wsa883x_dlkm.ko xc4000.ko xc5000.ko"

# Vibrator
TW_SUPPORT_INPUT_AIDL_HAPTICS := true

RECOVERY_BINARY_SOURCE_FILES += \
    $(TARGET_OUT_VENDOR_EXECUTABLES)/hw/vendor.qti.hardware.vibrator.service

TARGET_RECOVERY_DEVICE_MODULES += \
    libion \
    libdisplayconfig.qti \
    vendor.display.config@1.0 \
    vendor.display.config@2.0 

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so

PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

#Properties
TW_OVERRIDE_SYSTEM_PROPS := \
    "ro.build.date.utc;ro.build.fingerprint=ro.system.build.fingerprint;ro.build.version.incremental"
