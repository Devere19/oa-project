<template>
	<view>
		<view class="purchaseCard">
			<view>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">支出项目清单：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{officeExpense.itemsList}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">支出金额总计：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{officeExpense.expenses}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">日期：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{officeExpense.time}}</view>
					</uni-col>
				</uni-row>
			</view>
			<view>
				<uni-row>
					<uni-col class="center">
						<view>财务审核情况</view>
					</uni-col>
					<view class="financeStatus">
						<view class="contractContent">{{officeExpense.financeStaff}}</view>
						<uni-icons :style="'margin-left:15rpx'" type="checkmarkempty" size="24" color="#0081ff">
						</uni-icons>
					</view>
				</uni-row>
			</view>
			<view>
				<uni-row>
					<uni-col class="center">
						<view>董事会审核情况</view>
					</uni-col>
				</uni-row>
				<view class="auditStatusGroup">
					<view v-for="(statusItem,statusIndex) in officeExpense.officeDirector"
						:key="statusItem.userId" class="auditStatusItem">
						<view class="contractContent">{{statusItem.nickName}}</view>
						<view v-show="statusIndex==0">
							<uni-icons :style="'margin-left:15rpx'"
								:type="statusItem.state == null ? '' : 'checkmarkempty'" size="24" color="#0081ff">
							</uni-icons>
						</view>
						<view v-show="statusIndex==1">
							<uni-icons :style="'margin-left:15rpx'"
								:type="statusItem.state == null ? '' : 'checkmarkempty'" size="24" color="#0081ff">
							</uni-icons>
						</view>
						<view v-show="statusIndex==2">
							<uni-icons :style="'margin-left:15rpx'"
								:type="statusItem.state == null ? '' : 'checkmarkempty'" size="24" color="#0081ff">
							</uni-icons>
						</view>
					</view>
				</view>
			</view>
			<view v-show="officeExpense.cashier!=null">
				<uni-row>
					<uni-col class="center">
						<view>出纳付款情况</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">付款金额：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{officeExpense.paymentCount}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">付款时间：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{officeExpense.paymentTime}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col class="subTitle">
						<view>付款流水单截图</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col class="screenShotCenter">
						<image class="screenShot" mode="aspectFit"
							:src="officeExpense.paymentPhoto==null?'':officeExpense.paymentPhoto"
							@tap="viewScreenShot"></image>
					</uni-col>
				</uni-row>
			</view>
		</view>
		<view class="actionGroup">
			<view v-show="showPassFlag" class="actionGroupItem" @tap="actionsClick('pass')">
				<button class="buttonGroup" type="primary">通过</button>
			</view>
			<view class="actionGroupItem" @tap="actionsClick('back')">
				<button class="buttonGroup">返回</button>
			</view>
		</view>
	</view>
</template>

<script>
	import {
		dateConversion
	} from "@/common/unit/TimeFormatUnit.js"
	export default {
		data() {
			return {
				user: {
					userId: '',
					nickName: '',
				},
				officeExpense: null,
				showPassFlag: '',
				changeStateFlag:false,
			}
		},
		mounted() {
			//页面加载完成，获取本地存储的用户信息
			const userData = uni.getStorageSync('userInfo');
			if (userData) {
				this.user.userId = userData.userId;
				this.user.nickName = userData.nickName;
			}
		},
		// data为形参
		onLoad(data) {
			if(JSON.stringify(data)!='{}'){
				// 参数接收
				let receiveData=JSON.parse(JSON.stringify(data));
				this.reflashContract(receiveData.contractId);
			}else{
				this.reflashContract(this.officeExpense.id);
			}
		},
		onNavigationBarButtonTap() {
			uni.switchTab({
				url: "/pages/MainInterface/audit"
			})
		},
		methods: {
			viewScreenShot() {
				uni.previewImage({
					urls: [...this.officeExpense.paymentPhotoArray]
				})
			},
			// viewContractPhoto(){
			// 	uni.previewImage({
			// 		urls: [this.purchaseContract.contractPhoto]
			// 	})
			// },
			actionsClick(result) {
				if (result == "pass") {
					let that = this;
					uni.showModal({
						content: "您确定要‘通过’该单吗？",
						showCancel: true,
						success(res) {
							if (res.confirm) {
								that.$request({
									url: '/officeExpense/changeDirectorState',
									data: {
										officeExpenseId: that.officeExpense.id,
										userId: that.user.userId,
									}
								}).then(res => {
									if (res.code == 200) {
										if (res.data == 1) {
											that.showPassFlag=false
											that.changeStateFlag=true
											that.reflashContract(that.officeExpense.id)
											uni.showModal({
												content: "已通过！",
												showCancel: false
											})
										} else {
											uni.showModal({
												content: "修改失败",
												showCancel: false
											})
										}
									}
								}, err => {
									uni.showModal({
										content: "请求服务失败",
										showCancel: false
									})
								})
							}
						}
					})
				} else {
					if(this.changeStateFlag){
						uni.navigateTo({
							url:'/pages/audit/officeExpense'
						});
					}else{
						uni.navigateBack({
							delta:1
						})
					}
				}
			},
			reflashContract(id){
				this.$request({
					url: '/officeExpense/getOneDirectorOE',
					data: {
						id: id,
					}
				}).then(res => {
					if (res.code == 200) {
						this.officeExpense=res.data;
						this.officeExpense.time = dateConversion(this.officeExpense.time, 0);
						if(this.officeExpense.paymentTime!=null){
							this.officeExpense.paymentTime = dateConversion(this.officeExpense.paymentTime, 0);
						}
						this.showPassTF();
					}
				}, err => {
					uni.showModal({
						content: "请求服务失败",
						showCancel: false
					})
				})
			},
			showPassTF(){
				for(let i=0;i<this.officeExpense.officeDirector.length;i++){
					if(this.officeExpense.officeDirector[i].userId==this.user.userId){
						if(this.officeExpense.officeDirector[i].state==null){
							this.showPassFlag=true;
							break;
						}else{
							this.showPassFlag=false;
							break;
						}
					}
				}
			}
		}
	}
</script>

<style>
	.purchaseCard {
		width: 92%;
		margin-left: 3.5%;
		border-radius: 30rpx;
		border: #00ffff solid 5rpx;
		background-color: #ffffff;
	}

	.center {
		position: relative;
		/* #ifndef APP-NVUE */
		display: flex;
		/* #endif */
		flex-direction: column;
		align-items: center;
		justify-content: center;
		color: #0081ff;
		font-size: 32rpx;
		font-weight: bolder;
		border-top: 5rpx solid #00ffff;
		padding-top: 5rpx;
		padding-bottom: 5rpx;
	}

	.headLine {
		color: #009999;
		font-size: 28rpx;
		font-weight: bolder;
		margin-top: 10rpx;
		margin-bottom: 10rpx;
	}

	.contractContent {
		font-size: 28rpx;
		margin-top: 10rpx;
		margin-bottom: 10rpx;
	}

	.financeStatus {
		width: 100%;
		display: flex;
		align-items: center;
		flex-direction: row;
		justify-content: center;
		/* 		padding-top: 10rpx; */
	}

	.auditStatusGroup {
		width: 100%;
		display: flex;
		align-items: center;
		flex-direction: row;
		justify-content: center;
	}

	.auditStatusItem {
		width: 100%;
		display: flex;
		align-items: center;
		flex-direction: row;
		justify-content: center;
		/* margin-top: 10rpx; */
	}

	.subTitle {
		position: relative;
		/* #ifndef APP-NVUE */
		display: flex;
		/* #endif */
		flex-direction: column;
		align-items: center;
		justify-content: center;
		color: #0081ff;
		font-size: 28rpx;
		font-weight: bolder;
	}

	.tableGroup {
		margin-top: 20rpx;
		margin-bottom: 20rpx;
	}

	.screenShotCenter {
		position: relative;
		/* #ifndef APP-NVUE */
		display: flex;
		/* #endif */
		flex-direction: column;
		align-items: center;
		justify-content: center;
	}

	.screenShot {
		height: 640rpx;
		width: 320rpx;
	}

	.actionGroup {
		display: flex;
		align-items: center;
		flex-direction: row;
		justify-content: center;
	}

	.actionGroupItem {
		width: 100%;
		display: flex;
		align-items: center;
		flex-direction: row;
		justify-content: center;
	}

	.buttonGroup {
		width: 100%;
		height: 80rpx;
		font-size: 30rpx;
		margin: 20rpx;
		display: flex;
		align-items: center;
		flex-direction: row;
		justify-content: center;
	}
</style>