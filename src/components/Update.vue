<template>
  <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
    <el-form-item label="名称" prop="name">
      <el-input v-model="ruleForm.name"></el-input>
    </el-form-item>
    <el-form-item label="信息" prop="message">
      <el-input v-model="ruleForm.message"></el-input>
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click="updateForm('ruleForm',ruleForm)" v-if="isUpdate">
        更新修改
      </el-button>
      <el-button type="primary" @click="submitForm('ruleForm',ruleForm)" v-else>
        立即创建
      </el-button>
      <el-button @click="resetForm('ruleForm')">重置</el-button>
    </el-form-item>
  </el-form>
</template>

<script>
  export default {
    name: 'Update',
    data() {
      return {
        isUpdate: '',
        ruleForm: {
          name: '',
          message: '',
          delivery: false
        },
        rules: {
          name: [
            {required: true, message: '请输入名称', trigger: 'blur'},
            {min: 1, max: 15, message: '长度在 1 到 15 个字符', trigger: 'blur'}
          ],
          message: [
            {required: true, message: '请输入信息', trigger: 'blur'},
            {min: 1, max: 15, message: '长度在 1 到 15 个字符', trigger: 'blur'}
          ]
        }
      };

    },
    mounted: function () {
      this.isUpdateTrue();
    },
    methods: {
      submitForm(formName, ruleForm) {
        console.log(ruleForm);
        console.log(ruleForm.name);
        console.log(ruleForm.message);
        this.$refs[formName].validate((valid) => {
          if (valid) {
            // alert('submit!');
            this.$axios
              .put('/add', {
                name: ruleForm.name,
                message: ruleForm.message
              })
              .then(successResponse => {
                this.$message({
                  message: '添加成功',
                  type: 'success'
                });
                this.$router.push({path: '/index'});
                // alert('submit success!');
              })
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
      updateForm(formName, ruleForm) {
        console.log(ruleForm);
        this.$refs[formName].validate((valid) => {
          if (valid) {
            // alert('submit!');
            this.$axios
              .post('/edit', {
                id: this.$route.query.rowId,
                name: ruleForm.name,
                message: ruleForm.message
              })
              .then(successResponse => {
                //alert('update success!');
                this.$message({
                  message: '修改成功',
                  type: 'success'
                });
                this.$router.push({path: '/index'});
              })
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      },
      isUpdateTrue() {
        this.isUpdate = this.$route.query.isUpdate;
        let rowId = this.$route.query.rowId;
        if (rowId != undefined && rowId != '' && rowId != null) {
          this.$axios.get('/getMessageById', {
            params: {
              id: rowId
            }
          }).then(successResponse => {
            this.ruleForm.name = successResponse.data.name;
            this.ruleForm.message = successResponse.data.message;
          })
        }
      }
    }
  }
</script>

<style scoped>

</style>
