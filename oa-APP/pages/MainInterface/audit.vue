<template>
	<view>
		<!-- 搜索 -->
		<!-- <view class="searchBox"> -->
			<!-- 			<uni-search-bar v-model="searchValue" bgColor="#ffffff" :focus="false" @confirm="searchClick" @blur="searchBlur" @focus="searchFocus"
				@input="searchInput" @cancel="searchCancel" @clear="searchClear">
			</uni-search-bar> -->
<!-- 			<uni-search-bar v-model="searchValue" placeholder="请输入要搜索的内容" bgColor="#ffffff" :focus="false"
				@confirm="searchClick">
			</uni-search-bar> -->
		<!-- </view> -->
		<view class="cardGroup">
<!-- 			<uni-card :isFull="true" padding="0" title="采购单" extra="更多>" :style="'margin-top:15rpx'" @tap="toPurchase">
				<view>
					<uni-list v-for="(item,index) in purchaseList">
						<uni-list-item :title="item.goodsName" :rightText="item.supplier" link=""
							@tap="toDetail('purchase',item.contractNo)" showArrow></uni-list-item>
					</uni-list>
				</view>
			</uni-card> -->
			<uni-card :isFull="true" padding="0" title="采购付款单" extra="更多>" :style="'margin-top:15rpx'" @tap="toPurchasePayment">
			<!-- 当没有以下部分内容时，需要padding="0"这个属性，有的话，再去掉，否则排版不够美观 -->
				<!-- 				<uni-grid :column="3" :highlight="true" :showBorder="false" :square="false" @change="purchaseCardClick">
					<uni-grid-item v-for="(item, index) in purchaseCount" :index="index">
						<view class="numberCardItem">
							<view class="numberCardItemBorder"
								:style="{'border-right':index<2?'#8799a3 solid 1rpx':'0rpx'}">
								<text class="count">{{item.count}}</text>
								<text class="tips">{{item.tips}}</text>
							</view>
						</view>
					</uni-grid-item>
				</uni-grid> -->
				<view>
					<uni-list v-for="(item,index) in purchasePaymentList" :key="item.id">
						<uni-list-item :title="item.goodsName" :rightText="'￥'+item.paymentCount" link=""
							@tap="toDetail('purchasePayment',item.id)" showArrow></uni-list-item>
					</uni-list>
				</view>
			</uni-card>
			<uni-card :isFull="true" padding="0" title="加工付款单" extra="更多>" :style="'margin-top:15rpx'" @tap="toProcessPayment">
			<!-- 当没有以下部分内容时，需要padding="0"这个属性，有的话，再去掉，否则排版不够美观 -->
				<!-- 				<uni-grid :column="3" :highlight="true" :showBorder="false" :square="false" @change="purchaseCardClick">
					<uni-grid-item v-for="(item, index) in purchaseCount" :index="index">
						<view class="numberCardItem">
							<view class="numberCardItemBorder"
								:style="{'border-right':index<2?'#8799a3 solid 1rpx':'0rpx'}">
								<text class="count">{{item.count}}</text>
								<text class="tips">{{item.tips}}</text>
							</view>
						</view>
					</uni-grid-item>
				</uni-grid> -->
				<view>
					<uni-list v-for="(item,index) in processPaymentList" :key="item.id">
						<uni-list-item :title="item.goodsName" :rightText="'￥'+item.paymentCount" link=""
							@tap="toDetail('processPayment',item.id)" showArrow></uni-list-item>
					</uni-list>
				</view>
			</uni-card>
<!-- 			<uni-card :isFull="true" padding="0" title="销售单" extra="更多>" :style="'margin-top:15rpx'" @tap="toSale">
				<view>
					<uni-list v-for="(item,index) in purchaseList">
						<uni-list-item :title="item.goodsName" :rightText="item.supplier" link=""
							@tap="toDetail('purchase',item.contractNo)" showArrow></uni-list-item>
					</uni-list>
				</view>
			</uni-card>
			<uni-card :isFull="true" padding="0" title="物流单" extra="更多>" :style="'margin-top:15rpx'" @tap="toLogistics">
				<view>
					<uni-list v-for="(item,index) in logisticsList">
						<uni-list-item :title="'￥'+item.freight" :rightText="item.factoryName" link=""
							@tap="toDetail('logistics',item.contractNo)" showArrow>
						</uni-list-item>
					</uni-list>
				</view>
			</uni-card> -->
			<uni-card :isFull="true" padding="0" title="物流付款单" extra="更多>" :style="'margin-top:15rpx'" @tap="toLogisticsPayment">
<!-- 				<uni-grid :column="3" :highlight="true" :showBorder="false" :square="false"
					@change="logisticsCardClick">
					<uni-grid-item v-for="(item, index) in logisticsCount" :index="index">
						<view class="numberCardItem">
							<view class="numberCardItemBorder"
								:style="{'border-right':index<2?'#8799a3 solid 1rpx':'0rpx'}">
								<text class="count">{{item.count}}</text>
								<text class="tips">{{item.tips}}</text>
							</view>
						</view>
					</uni-grid-item>
				</uni-grid> -->
				<view>
					<uni-list v-for="(item,index) in logisticsPaymentList" :key="item.id">
						<uni-list-item :title="item.goodsName" :rightText="'￥'+item.paymentCount" link=""
							@tap="toDetail('logisticsPayment',item.id)" showArrow>
						</uni-list-item>
					</uni-list>
				</view>
			</uni-card>
			<uni-card :isFull="true" padding="0" title="海运单" extra="更多>" :style="'margin-top:15rpx'" @tap="toShipping">
				<!-- 				<uni-grid :column="3" :highlight="true" :showBorder="false" :square="false" @change="shippingClick">
					<uni-grid-item v-for="(item, index) in shoppingCount" :index="index">
						<view class="numberCardItem">
							<view class="numberCardItemBorder"
								:style="{'border-right':index<2?'#8799a3 solid 1rpx':'0rpx'}">
								<text class="count">{{item.count}}</text>
								<text class="tips">{{item.tips}}</text>
							</view>
						</view>
					</uni-grid-item>
				</uni-grid> -->
				<view>
					<uni-list v-for="(item,index) in shippingList" :key="item.shippingContractNo">
						<uni-list-item :title="item.principal" :rightText="'￥'+item.expenses" link=""
							@tap="toDetail('shipping',item.id)" showArrow>
							<!-- 						<uni-list-item :title="'￥'+item.expenses" :rightText="item.CarrierCompanyName" :link="{url:'/pages/detail/shippingDetail?contractNo='+contractNo}" @tap="toDetail('shipping',item.contractNo)" showArrow> -->
						</uni-list-item>
					</uni-list>
				</view>
			</uni-card>
			<uni-card :isFull="true" padding="0" title="办公经费单" extra="更多>" :style="'margin-top:15rpx'"
				@tap="toOfficeExpense">
				<view>
					<uni-list v-for="(item,index) in officeExpenseList" :key="item.id">
						<uni-list-item :title="item.itemsList" :rightText="'￥'+item.expenses" link=""
							@tap="toDetail('officeExpense',item.id)" showArrow></uni-list-item>
					</uni-list>
				</view>
			</uni-card>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				searchValue: "",
				user: {
					userId: '',
					nickName: '',
				},
				purchasePaymentList:[],
				processPaymentList:[],
				logisticsPaymentList:[],
				shippingList:[],
				officeExpenseList:[],
			}
		},
		created() {
			//页面加载完成，获取本地存储的用户信息
			const userData = uni.getStorageSync('userInfo');
			if (userData) {
				this.user.userId = userData.userId;
				this.user.nickName = userData.nickName;
				this.reflash();
			}
		},
		methods: {
			searchClick(res) {
				uni.showToast({
					title: '搜索：' + res.value,
					icon: 'none'
				})
			},
			// searchInput(res) {
			// 	console.log('----input:', res)
			// },
			// searchClear(res) {
			// 	uni.showToast({
			// 		title: 'clear事件，清除值为：' + res.value,
			// 		icon: 'none'
			// 	})
			// },
			// searchBlur(res) {
			// 	uni.showToast({
			// 		title: 'blur事件，输入值为：' + res.value,
			// 		icon: 'none'
			// 	})
			// },
			// searchFocus(e) {
			// 	uni.showToast({
			// 		title: 'focus事件，输出值为：' + e.value,
			// 		icon: 'none'
			// 	})
			// },
			// searchCancel(res) {
			// 	uni.showToast({
			// 		title: '点击取消，输入值为：' + res.value,
			// 		icon: 'none'
			// 	})
			// },
			reflash(){
				// 获取采购付款单的信息
				this.$request({
					url: '/purchasePaymentContract/getDirectorPPC',
					data: {
						current: 1,
						page: 5,
						userId: this.user.userId,
						type: 0
					}
				}).then(res=>{
					if(res.code==200){
						this.purchasePaymentList=res.data.records;
						console.log(this.purchasePaymentList);
					}
				},
				err=>{
					uni.showModal({
						content: "请求服务失败",
						showCancel: false
					})
				})
				// 获取加工付款单的信息
				this.$request({
					url: '/processPaymentContract/getDirectorPPC',
					data: {
						current: 1,
						page: 5,
						userId: this.user.userId,
						type: 0
					}
				}).then(res=>{
					if(res.code==200){
						this.processPaymentList=res.data.records;
						console.log(this.processPaymentList);
					}
				},
				err=>{
					uni.showModal({
						content: "请求服务失败",
						showCancel: false
					})
				})
				// 获取物流付款单的信息
				this.$request({
					url: '/logisticsPaymentContract/getDirectorLPC',
					data: {
						current: 1,
						page: 5,
						userId: this.user.userId,
						type: 0
					}
				}).then(res=>{
					if(res.code==200){
						this.logisticsPaymentList=res.data.records;
						console.log(this.logisticsPaymentList);
					}
				},
				err=>{
					uni.showModal({
						content: "请求服务失败",
						showCancel: false
					})
				})
				// 获取海运单的信息
				this.$request({
					url: '/shippingContract/getDirectorSC',
					data: {
						current: 1,
						page: 5,
						userId: this.user.userId,
						type: 0
					}
				}).then(res=>{
					if(res.code==200){
						this.shippingList=res.data.records;
						console.log(this.shippingList);
					}
				},
				err=>{
					uni.showModal({
						content: "请求服务失败",
						showCancel: false
					})
				})
				// 获取办公经费的信息
				this.$request({
					url: '/officeExpense/getDirectorOE',
					data: {
						current: 1,
						page: 5,
						userId: this.user.userId,
						type: 0
					}
				}).then(res=>{
					if(res.code==200){
						this.officeExpenseList=res.data.records;
						console.log(this.officeExpenseList);
					}
				},
				err=>{
					uni.showModal({
						content: "请求服务失败",
						showCancel: false
					})
				})
			},
			// purchaseCardClick(e) {
			// 	if (e.detail.index == 0) {
			// 		uni.navigateTo({
			// 			// 普通参数传输
			// 			url: '/pages/audit/purchase'
			// 		})
			// 	} else if (e.detail.index == 1) {
			// 		uni.navigateTo({
			// 			// 普通参数传输
			// 			url: '/pages/audit/purchase?chooseForm=' + 1
			// 		})
			// 	} else {
			// 		uni.navigateTo({
			// 			// 普通参数传输
			// 			url: '/pages/audit/purchase?chooseForm=' + 2
			// 		})
			// 	}
			// },
			// logisticsCardClick(e) {
			// 	if (e.detail.index == 0) {
			// 		uni.navigateTo({
			// 			// 普通参数传输
			// 			url: '/pages/audit/logistics'
			// 		})
			// 	} else if (e.detail.index == 1) {
			// 		uni.navigateTo({
			// 			// 普通参数传输
			// 			url: '/pages/audit/logistics?chooseForm=' + 1
			// 		})
			// 	} else {
			// 		uni.navigateTo({
			// 			// 普通参数传输
			// 			url: '/pages/audit/logistics?chooseForm=' + 2
			// 		})
			// 	}
			// },
			// shippingClick(e) {
			// 	if (e.detail.index == 0) {
			// 		uni.navigateTo({
			// 			// 普通参数传输
			// 			url: '/pages/audit/shipping'
			// 		})
			// 	} else if (e.detail.index == 1) {
			// 		uni.navigateTo({
			// 			// 普通参数传输
			// 			url: '/pages/audit/shipping?chooseForm=' + 1
			// 		})
			// 	} else {
			// 		uni.navigateTo({
			// 			// 普通参数传输
			// 			url: '/pages/audit/shipping?chooseForm=' + 2
			// 		})
			// 	}
			// },
			toPurchase(e) {
				if (e == "extra") {
					uni.navigateTo({
						url: "/pages/audit/purchase"
					})
				}
			},
			toPurchasePayment(e) {
				if (e == "extra") {
					uni.navigateTo({
						url: "/pages/audit/purchasePayment"
					})
				}
			},
			toProcessPayment(e) {
				if (e == "extra") {
					uni.navigateTo({
						url: "/pages/audit/processPayment"
					})
				}
			},
			toSale(e) {
				if (e == "extra") {
					uni.navigateTo({
						url: "/pages/audit/sale"
					})
				}
			},
			toLogistics(e) {
				if (e == "extra") {
					uni.navigateTo({
						url: "/pages/audit/logistics"
					})
				}
			},
			toLogisticsPayment(e) {
				if (e == "extra") {
					uni.navigateTo({
						url: "/pages/audit/logisticsPayment"
					})
				}
			},
			toShipping(e) {
				if (e == "extra") {
					uni.navigateTo({
						url: "/pages/audit/shipping"
					})
				}
			},
			toOfficeExpense(e) {
				if (e == "extra") {
					uni.navigateTo({
						url: "/pages/audit/officeExpense"
					})
				}
			},
			toDetail(type, contractNo) {
				if (type == "purchase") {
					uni.navigateTo({
						// 普通参数传输
						url: '/pages/detail/purchaseDetail?contractId=' + contractNo
					})
				} else if (type == "purchasePayment") {
					uni.navigateTo({
						// 普通参数传输
						url: '/pages/detail/purchasePaymentDetail?contractId=' + contractNo
					})
				} else if (type == "processPayment") {
					uni.navigateTo({
						// 普通参数传输
						url: '/pages/detail/processPaymentDetail?contractId=' + contractNo
					})
				} else if (type == "sale") {
					uni.navigateTo({
						// 普通参数传输
						url: '/pages/detail/saleDetail?contractId=' + contractNo
					})
				}
				else if (type == "logistics") {
					uni.navigateTo({
						// 普通参数传输
						url: '/pages/detail/logisticsDetail?contractId=' + contractNo
					})
				}else if (type == "logisticsPayment") {
					uni.navigateTo({
						// 普通参数传输
						url: '/pages/detail/logisticsPaymentDetail?contractId=' + contractNo
					})
				}else if (type == "shipping") {
					uni.navigateTo({
						// 普通参数传输
						url: '/pages/detail/shippingDetail?contractId=' + contractNo
					})
				} else {
					uni.navigateTo({
						// 普通参数传输
						url: '/pages/detail/officeExpenseDetail?contractId=' + contractNo
					})
				}
			}
		}
	}
</script>

<style>
	.numberCard {
		display: flex;
		align-items: center;
		flex-direction: row;
		justify-content: center;
		top: 210rpx;
		height: 165rpx;
		width: 92%;
		margin-left: 3.5%;
		border-radius: 30rpx;
		border: #00ffff solid 5rpx;
		background-color: #ffffff;
		box-shadow: -5rpx 5rpx 15rpx #00ffff;
		position: absolute;
	}

	.numberCardItem {
		height: 150rpx;
		border-radius: 50rpx;
		flex: 1;
	}

	.numberCardItemBorder {
		position: relative;
		/* #ifndef APP-NVUE */
		display: flex;
		/* #endif */
		flex-direction: column;
		align-items: center;
		justify-content: center;
	}

	.count {
		color: #0081ff;
		font-size: 50rpx;
		margin-bottom: 3%;
	}

	.tips {
		color: #8799a3;
	}

	.listItem {
		margin-top: 20rpx
	}
</style>
