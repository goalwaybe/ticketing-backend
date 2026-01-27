<template>
    <!-- 对话框表单 -->
    <!-- 建议使用 Prettier 格式化代码 -->
    <!-- el-form 内可以混用 el-form-item、FormItem、ba-input 等输入组件 -->
    <el-dialog
        class="ba-operate-dialog"
        :close-on-click-modal="false"
        :model-value="['Add', 'Edit'].includes(baTable.form.operate!)"
        @close="baTable.toggleForm"
    >
        <template #header>
            <div class="title" v-drag="['.ba-operate-dialog', '.el-dialog__header']" v-zoom="'.ba-operate-dialog'">
                {{ baTable.form.operate ? t(baTable.form.operate) : '' }}
            </div>
        </template>
        <el-scrollbar v-loading="baTable.form.loading" class="ba-table-form-scrollbar">
            <div
                class="ba-operate-form"
                :class="'ba-' + baTable.form.operate + '-form'"
                :style="config.layout.shrink ? '' : 'width: calc(100% - ' + baTable.form.labelWidth! / 2 + 'px)'"
            >
                <el-form
                    v-if="!baTable.form.loading"
                    ref="formRef"
                    @submit.prevent=""
                    @keyup.enter="baTable.onSubmit(formRef)"
                    :model="baTable.form.items"
                    :label-position="config.layout.shrink ? 'top' : 'right'"
                    :label-width="baTable.form.labelWidth + 'px'"
                >
                    <!-- :rules="rules" -->
                    <FormItem
                        :label="t('ticketuser.userProfile.real_name')"
                        type="string"
                        v-model="baTable.form.items!.real_name"
                        prop="real_name"
                        :placeholder="t('Please input field', { field: t('ticketuser.userProfile.real_name') })"
                    />
                    <FormItem
                        :label="t('ticketuser.userProfile.account_name')"
                        type="string"
                        v-model="baTable.form.items!.account_name"
                        prop="account_name"
                        :placeholder="t('Please input field', { field: t('ticketuser.userProfile.account_name') })"
                    />
                    <FormItem
                        :label="t('ticketuser.userProfile.wechat_id')"
                        type="remoteSelect"
                        v-model="baTable.form.items!.wechat_id"
                        prop="wechat_id"
                        :input-attr="{ pk: 'id', field: 'name', remoteUrl: '' }"
                        :placeholder="t('Please select field', { field: t('ticketuser.userProfile.wechat_id') })"
                    />
                    <FormItem
                        :label="t('ticketuser.userProfile.bank_card_no')"
                        type="string"
                        v-model="baTable.form.items!.bank_card_no"
                        prop="bank_card_no"
                        :placeholder="t('Please input field', { field: t('ticketuser.userProfile.bank_card_no') })"
                    />
                    <FormItem
                        :label="t('ticketuser.userProfile.id_card_no')"
                        type="string"
                        v-model="baTable.form.items!.id_card_no"
                        prop="id_card_no"
                        :placeholder="t('Please input field', { field: t('ticketuser.userProfile.id_card_no') })"
                    />
                    <FormItem
                        :label="t('ticketuser.userProfile.id_card1_image')"
                        type="image"
                        v-model="baTable.form.items!.id_card1_image"
                        prop="id_card1_image"
                    />
                    <FormItem
                        :label="t('ticketuser.userProfile.id_card2_image')"
                        type="image"
                        v-model="baTable.form.items!.id_card2_image"
                        prop="id_card2_image"
                    />
                    <FormItem
                        :label="t('ticketuser.userProfile.wechat_qr_image')"
                        type="image"
                        v-model="baTable.form.items!.wechat_qr_image"
                        prop="wechat_qr_image"
                    />
                    <FormItem
                        :label="t('ticketuser.userProfile.alipay_qr_image')"
                        type="image"
                        v-model="baTable.form.items!.alipay_qr_image"
                        prop="alipay_qr_image"
                    />
                </el-form>
            </div>
        </el-scrollbar>
        <template #footer>
            <div :style="'width: calc(100% - ' + baTable.form.labelWidth! / 1.8 + 'px)'">
                <el-button @click="baTable.toggleForm()">{{ t('Cancel') }}</el-button>
                <el-button v-blur :loading="baTable.form.submitLoading" @click="baTable.onSubmit(formRef)" type="primary">
                    {{ baTable.form.operateIds && baTable.form.operateIds.length > 1 ? t('Save and edit next item') : t('Save') }}
                </el-button>
            </div>
        </template>
    </el-dialog>
</template>

<script setup lang="ts">
import {
  inject,
  reactive,
  useTemplateRef,
} from 'vue';

import FormItem from '/@/components/formItem/index.vue';
import { useConfig } from '/@/stores/config';
import type baTableClass from '/@/utils/baTable';
import { buildValidatorData } from '/@/utils/validate';
import type { FormItemRule } from 'element-plus';
import { useI18n } from 'vue-i18n';

const config = useConfig()
const formRef = useTemplateRef('formRef')
const baTable = inject('baTable') as baTableClass

const { t } = useI18n()

const rules: Partial<Record<string, FormItemRule[]>> = reactive({
    created_at: [buildValidatorData({ name: 'date', title: t('ticketuser.userProfile.created_at') })],
    updated_at: [buildValidatorData({ name: 'date', title: t('ticketuser.userProfile.updated_at') })],
})
</script>

<style scoped lang="scss"></style>
