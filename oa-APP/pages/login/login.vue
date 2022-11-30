<template>
	<view>
		<image :src="JuNlogo" style="width: 86%;height:650rpx;margin-left: 7%;margin-right: 7%;"></image>
		<uni-forms ref="form" :modelValue="formData" :rules="rules" err-show-type="toast">
			<!-- prefixIcon为左侧 -->
			<!-- suffixIcon为右侧 -->
			<uni-forms-item name="username" class="usernameInput">
				<uni-easyinput class="input" :styles="styles" :placeholderStyle="placeholderStyle"
					prefixIcon="person-filled" v-model="formData.username" placeholder="请输入账号、手机号或用户名"></uni-easyinput>
			</uni-forms-item>
			<uni-forms-item name="password" class="passwordInput">
				<uni-easyinput class="input" :styles="styles" :placeholderStyle="placeholderStyle" type="password"
					v-model="formData.password" placeholder="请输入密码"></uni-easyinput>
			</uni-forms-item>
		</uni-forms>
		<!-- <view style="display: flex;flex-direction: row;"> -->
			<!-- 记住密码 -->
<!-- 			<checkbox-group @change="remTF"
				style="height: 80rpx;width: 28%;margin-left: 36%;margin-right: 36%;font-size: 85%;text-align: center;color: #2979FF;">
				<label>
					<checkbox value="yes" :checked="remenberPwd" />记住密码
				</label>
			</checkbox-group> -->
			<!-- 记住密码和忘记密码 -->
<!-- 			<checkbox-group @change="remTF"
				style="height: 80rpx;width: 28%;margin-left: 16%;margin-right: 6%;font-size: 85%;text-align: center;color: #2979FF;">
				<label>
					<checkbox value="yes" :checked="remenberPwd" />记住密码
				</label>
			</checkbox-group> -->
<!-- 			<view
				style="height: 80rpx;width: 28%;margin-left: 6%;margin-right: 16%;font-size: 85%;text-align: center;color: #2979FF;">
				<label @click="forgetPwd">忘记密码 ?</label>
			</view> -->
		<!-- </view> -->
		<view style="display: flex;flex-direction: row;">
			<!-- 仅登录 -->
			<button type="primary" @click="submit"
				style="height: 80rpx;width: 28%;margin-left: 36%;margin-right: 36%;font-size: 100%;">登录</button>
				<!-- 登录和注册 -->
<!-- 			<button type="primary" @click="submit"
				style="height: 80rpx;width: 28%;margin-left: 16%;margin-right: 6%;font-size: 100%;">登录</button>
			<button type="primary" @click="register"
				style="height: 80rpx;width: 28%;margin-left: 6%;margin-right: 16%;font-size: 100%;">注册</button> -->
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				JuNlogo: '/static/logo.png',
				placeholderStyle: "color:#2979FF;font-size:100%",
				styles: {
					color: '#2979FF',
					borderColor: '#2979FF',
				},
				formData: {
					username: '',
					password: ''
				},
				remenberPwd: true,
				rules: {
					// 对username字段进行必填验证
					username: {
						rules: [{
							required: true,
							errorMessage: '请输入账号信息',
						}]
					},
					// 对password字段进行必填验证
					password: {
						rules: [{
								required: true,
								errorMessage: '请输入密码',
							},
							{
								minLength: 6,
								// maxLength: 5,
								errorMessage: '密码长度最短为{minLength}个字符',
							}
						]
					}
				}
			}
		},
		onLoad(data) {
			//页面加载完成，获取本地存储的用户名及密码
			const userData = uni.getStorageSync('username');
			if (userData.username && userData.password) {
				this.formData.username = userData.username;
				this.formData.password = userData.password;
				if(JSON.stringify(data)=='{}'){
					this.login(this.formData);
				}
			}
		},
		methods: {
			// 触发提交表单
			async submit() {
				this.$refs.form.validate().then(res => {
					console.log('表单数据信息：', res);
					this.login(res);
				})
			},
			login(res){
				uni.request({
					url: 'http://120.77.28.123:9000/login',
					method: "POST",
					data: JSON.stringify(res),
				}).then(
					result => {
						if (result[1].data.code == 200) {
							// 存储token
							uni.setStorage({
								key: 'token',
								data: {
									token: result[1].data.data.token,
								},
								success: function() {
									console.log('记录token');
								}
							});
							// 获取用户信息
							this.$request({
								url: '/api/user/nickName/' + res.username,
							}).then(userResult => {
								if (userResult.code == 200) {
									if(userResult.data.roleNames=="董事会"&&userResult.data.status=="在职"){
										// 存储用户信息
										uni.setStorage({
											key: 'userInfo',
											data: {
												userId:userResult.data.id,
												nickName: userResult.data.nickName,
											},
											success: function() {
												console.log('记录当前登录用户信息');
											}
										});
										uni.reLaunch({
											url: '/pages/MainInterface/audit'
										})
									}else{
										uni.showModal({
											content: '该账号无登录本系统的权限',
											showCancel: false
										});
									}
								}
							});
							// 自动登录，不再判断是否记住密码
							uni.setStorage({
								key: 'username',
								data: this.formData,
								success: function() {
									console.log('账号信息缓存成功');
								}
							})
							// 记住密码的功能实现
							// if (this.remenberPwd == true) {
							// 	uni.setStorage({
							// 		key: 'username',
							// 		data: this.formData,
							// 		success: function() {
							// 			console.log('账号信息缓存成功');
							// 		}
							// 	})
							// };
							// if (this.remenberPwd == false) {
							// 	uni.removeStorage({
							// 		key: 'username',
							// 		success: function(res) {
							// 			console.log('移除上次的缓存');
							// 		}
							// 	});
							// };
						} else if (result.code == 500) {
							uni.showModal({
								content: '用户名或密码不正确，请检查',
								showCancel: false
							});
						}
					},
					err => {
						uni.showModal({
							content: "请求服务失败",
							showCancel: false
						})
					}
				)
			},
			// 注册跳转
			// register() {
			// 	uni.navigateTo({
			// 		url: '/pages/Login/register'
			// 	})
			// },
			// 忘记密码跳转
			// forgetPwd() {
			// 	uni.navigateTo({
			// 		url: '/pages/Login/updatePwd'
			// 	});
			// },
			// 记住密码
			// remTF(e) {
			// 	console.log(e);
			// 	if (e.detail.value == "") {
			// 		this.remenberPwd = false;
			// 	} else {
			// 		this.remenberPwd = true;
			// 	}
			// }
		}
	}
</script>

<style>
	page {
		background-color: #ffffff !important;
	}

	.usernameInput {
		width: 68%;
		margin-bottom: 4%;
		margin-left: 16%;
		margin-right: 16%;
	}

	.passwordInput {
		width: 68%;
		margin-left: 16%;
		margin-right: 16%;
	}

	.input {
		background-color: #f5f5f5;
	}
</style>
