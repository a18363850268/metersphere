<template>
  <el-dialog :title="$t('table.header_display_field')" :visible.sync="visible" :append-to-body="true">
    <tree-transfer :title="[$t('table.fields_to_be_selected'), $t('table.selected_fields')]"
                   :from_data='fromFields'
                   :placeholder="$t('api_test.request.parameters_mock_filter_tips')"
                   :draggable="true"
                   :to_data='selectedFields'
                   :defaultProps="{label:'label'}"
                   :allow-drop="allowDrop"
                   :default-checked-keys="selectedKeys"
                   :default-transfer="defaultTransfer"
                   :mode='mode' filter openAll/>
    <template v-slot:footer>
      <ms-dialog-footer @cancel="close" @confirm="saveHeader"/>
    </template>
  </el-dialog>
</template>

<script>
import MsDialogFooter from "@/business/components/common/components/MsDialogFooter";
import treeTransfer from 'el-tree-transfer'
import {getAllFieldWithCustomFields, saveCustomTableHeader} from "@/common/js/tableUtils";
import {SYSTEM_FIELD_NAME_MAP} from "@/common/js/table-constants";

export default {
  name: "MsCustomTableHeader",
  components: {MsDialogFooter, treeTransfer},
  data() {
    return {
      visible: false,
      value: [],
      fromFields: [],
      selectedFields: [],
      selectedKeys: [],
      defaultTransfer: true,
      mode: "transfer", // transfer addressList
    }
  },
  props: {
    type: String,
    customFields: Array
  },
  methods: {
    allowDrop(draggingNode, dropNode, type) {
      return type !== 'inner';
    },
    open(items) {
      items = JSON.parse(JSON.stringify(items));
      items.forEach(it => {
        if (it.isCustom) {
          // i18n
          it.label = SYSTEM_FIELD_NAME_MAP[it.id] ? this.$t(SYSTEM_FIELD_NAME_MAP[it.id]) : it.label;
        }
      })
      let hasRemoveField = undefined;
      if (this.customFields) {
        let index = this.customFields.findIndex(c => c.remove === true);
        if (index > -1) {
          hasRemoveField = this.customFields[index];
        }
      }
      let fields = getAllFieldWithCustomFields(this.type, this.customFields);
      this.selectedKeys = [];
      this.fromFields = [];
      this.selectedKeys = items.map(item => item.key);
      this.selectedFields = items;
      for (let field of fields) {
        if (this.selectedKeys.indexOf(field.key) < 0) {
          if (field.isCustom) {
            field.label = SYSTEM_FIELD_NAME_MAP[field.id] ? this.$t(SYSTEM_FIELD_NAME_MAP[field.id]) : field.label
          }
          if (hasRemoveField && field.id === hasRemoveField.id) {
            continue;
          }
          this.fromFields.push(field);
        }
      }
      this.visible = true;
    },
    saveHeader() {
      saveCustomTableHeader(this.type, this.selectedFields);
      this.$success(this.$t("commons.save_success"));
      this.$emit('reload');
      this.close();
    },
    removeAt(idx) {
      this.list.splice(idx, 1);
    },
    close() {
      this.visible = false
    },

    // 切换模式 现有树形穿梭框模式transfer 和通讯录模式addressList
    // changeMode() {
    //   if (this.mode == "transfer") {
    //     this.mode = "addressList";
    //   } else {
    //     this.mode = "transfer";
    //   }
    // },
    // // 监听穿梭框组件添加
    // add(fromData, toData, obj){
    //   // 树形穿梭框模式transfer时，返回参数为左侧树移动后数据、右侧树移动后数据、移动的{keys,nodes,halfKeys,halfNodes}对象
    //   // 通讯录模式addressList时，返回参数为右侧收件人列表、右侧抄送人列表、右侧密送人列表
    //   console.log("fromData:", fromData);
    //   console.log("toData:", toData);
    //   console.log("obj:", obj);
    // },
    // // 监听穿梭框组件移除
    // remove(fromData, toData, obj){
    //   // 树形穿梭框模式transfer时，返回参数为左侧树移动后数据、右侧树移动后数据、移动的{keys,nodes,halfKeys,halfNodes}对象
    //   // 通讯录模式addressList时，返回参数为右侧收件人列表、右侧抄送人列表、右侧密送人列表
    //   console.log("fromData:", fromData);
    //   console.log("toData:", toData);
    //   console.log("obj:", obj);
    // }
  }
}
</script>

<style>
.wl-transfer .transfer-main {
  height: calc(100% - 73px) !important;
}
</style>
