<template>
	<view>
		<view class="shippingCard">
			<view>
				<uni-row>
					<uni-col class="center" style="border-top: 0rpx solid #00ffff">
						<view>{{shippingContract.shippingContractNo}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">运输合同编号：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.logisticsContractNo}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">委托方：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.principal}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">装箱日期：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.packingTime}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">装箱地点：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.packingLocation}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">卸货工厂：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.unpackingFactory}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">集装箱号：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.containerNo}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">铅封号：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.sealNo}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">理货员：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.tallyClerk}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">理货费用：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.tallyClerkPrice}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">起运承运车队：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.departureFleet}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">起运车队费用：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.departurePrice}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">承运船公司：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.carrierCompanyName}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">承运船费用：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.carrierCompanyPrice}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">目的港承运车队：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.destinationPortFleet}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">目的港车队费用：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.destinationPortPrice}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">总费用：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.expenses}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col class="subTitle">
						<view>合同</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col class="screenShotCenter">
						<image class="screenShot" mode="aspectFit"
							:src="shippingContract.contractPhoto==null?'':shippingContract.contractPhoto"
							@tap="viewContractPhoto"></image>
					</uni-col>
				</uni-row>
			</view>
			<view>
				<uni-row>
					<uni-col class="center">
						<view>财务审核情况</view>
					</uni-col>
					<view class="financeStatus">
						<view class="contractContent">{{shippingContract.financeStaff}}</view>
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
					<view v-for="(statusItem,statusIndex) in shippingContract.shippingDirector"
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
			<view v-show="shippingContract.cashier!=null">
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
						<view class="contractContent">{{shippingContract.paymentCount}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">付款时间：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{shippingContract.paymentTime}}</view>
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
							:src="shippingContract.paymentPhoto==null?'':shippingContract.paymentPhoto"
							@tap="viewscreenShot"></image>
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
				shippingContract: null,
				showPassFlag: '',
				changeStateFlag: false,
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
				this.reflashContract(this.shippingContract.id);
			}
		},
		onNavigationBarButtonTap() {
			uni.switchTab({
				url: "/pages/MainInterface/audit"
			})
		},
		methods: {
			viewscreenShot() {
				uni.previewImage({
					urls: [...this.shippingContract.paymentPhotoArray]
				})
			},
			viewContractPhoto(){
				uni.previewImage({
					urls: [...this.shippingContract.contractPhotoArray]
				})
			},
			actionsClick(result) {
				if (result == "pass") {
					let that = this;
					uni.showModal({
						content: "您确定要‘通过’该单吗？",
						showCancel: true,
						success(res) {
							if (res.confirm) {
								that.$request({
									url: '/shippingContract/changeDirectorState',
									data: {
										shippingContractNo: that.shippingContract.shippingContractNo,
										userId: that.user.userId,
									}
								}).then(res => {
									if (res.code == 200) {
										if (res.data == 1) {
											that.showPassFlag=false
											that.changeStateFlag=true
											that.reflashContract(that.shippingContract.id)
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
							url:'/pages/audit/shipping'
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
					url: '/shippingContract/getOneDirectorSC',
					data: {
						id: id,
					}
				}).then(res => {
					if (res.code == 200) {
						this.shippingContract=res.data;
						this.shippingContract.packingTime = dateConversion(this.shippingContract.packingTime, 0);
						if(this.shippingContract.paymentTime!=null){
							this.shippingContract.paymentTime = dateConversion(this.shippingContract.paymentTime, 0);
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
				for(let i=0;i<this.shippingContract.shippingDirector.length;i++){
					if(this.shippingContract.shippingDirector[i].userId==this.user.userId){
						if(this.shippingContract.shippingDirector[i].state==null){
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
	.shippingCard {
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
