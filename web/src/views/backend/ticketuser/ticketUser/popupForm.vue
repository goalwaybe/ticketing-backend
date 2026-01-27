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
                    :rules="rules"
                >
                    <FormItem
                        :label="t('ticketuser.ticketUser.phone')"
                        type="string"
                        v-model="baTable.form.items!.phone"
                        prop="phone"
                        :placeholder="t('Please input field', { field: t('ticketuser.ticketUser.phone') })"
                    />
                    <FormItem :label="t('ticketuser.ticketUser.avatar')" type="image" v-model="baTable.form.items!.avatar" prop="avatar" />
                    <FormItem
                        :label="t('ticketuser.ticketUser.gender')"
                        type="number"
                        v-model="baTable.form.items!.gender"
                        prop="gender"
                        :input-attr="{
                            content: {
                                '0': t('ticketuser.ticketUser.gender 0'),
                                ' 1': t('ticketuser.ticketUser.gender  1'),
                                ' 2': t('ticketuser.ticketUser.gender  2'),
                            },
                        }"
                        :placeholder="t('Please input field', { field: t('ticketuser.ticketUser.gender') })"
                    />
                    <FormItem
                        :label="t('ticketuser.ticketUser.status')"
                        type="number"
                        v-model="baTable.form.items!.status"
                        prop="status"
                        :input-attr="{
                            content: {
                                '0': t('ticketuser.ticketUser.status 0'),
                                ' 1': t('ticketuser.ticketUser.status  1'),
                                ' 2': t('ticketuser.ticketUser.status  2'),
                            },
                        }"
                        :placeholder="t('Please input field', { field: t('ticketuser.ticketUser.status') })"
                    />

                    <!-- 密码字段 -->
                    <FormItem
                        v-if="baTable.form.operate === 'Edit'"
                        :label="t('ticketuser.ticketUser.password')"
                        type="string"
                        v-model="baTable.form.items!.password"
                        prop="password"
                        :placeholder="t('Please input field', { field: t('ticketuser.ticketUser.password') })"
                        :input-attr="{
                            type: 'password',
                            showPassword: true
                        }"
                    />

<!--                    <FormItem-->
<!--                        :label="t('ticketuser.ticketUser.role')"-->
<!--                        type="number"-->
<!--                        v-model="baTable.form.items!.role"-->
<!--                        prop="role"-->
<!--                        :input-attr="{-->
<!--                            content: {-->
<!--                                '0': t('ticketuser.ticketUser.role 0'),-->
<!--                                ' 1': t('ticketuser.ticketUser.role  1'),-->
<!--                                ' 2': t('ticketuser.ticketUser.role  2'),-->
<!--                                ' 9': t('ticketuser.ticketUser.role  9'),-->
<!--                            },-->
<!--                        }"-->
<!--                        :placeholder="t('Please input field', { field: t('ticketuser.ticketUser.role') })"-->
<!--                    />-->
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
import type { FormItemRule } from 'element-plus'
import { inject, reactive, useTemplateRef } from 'vue'
import { useI18n } from 'vue-i18n'
import FormItem from '/@/components/formItem/index.vue'
import { useConfig } from '/@/stores/config'
import type baTableClass from '/@/utils/baTable'
import { buildValidatorData } from '/@/utils/validate'

const config = useConfig()
const formRef = useTemplateRef('formRef')
const baTable = inject('baTable') as baTableClass

const { t } = useI18n()

const rules: Partial<Record<string, FormItemRule[]>> = reactive({
    gender: [buildValidatorData({ name: 'number', title: t('ticketuser.ticketUser.gender') })],
    status: [buildValidatorData({ name: 'number', title: t('ticketuser.ticketUser.status') })],
    role: [buildValidatorData({ name: 'number', title: t('ticketuser.ticketUser.role') })],
    created_at: [buildValidatorData({ name: 'date', title: t('ticketuser.ticketUser.created_at') })],
    updated_at: [buildValidatorData({ name: 'date', title: t('ticketuser.ticketUser.updated_at') })],
    deleted_at: [buildValidatorData({ name: 'date', title: t('ticketuser.ticketUser.deleted_at') })],
})
</script>

<style scoped lang="scss"></style>
