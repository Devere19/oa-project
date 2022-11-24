<template>
	<view>
		<view class="topBackGround">
			<view class="nullBG">
				&nbsp;
			</view>
		</view>
		<view class="topCard">
			<uni-grid :column="3" :highlight="true" :showBorder="false" :square="false" @change="topCardClick">
				<uni-grid-item v-for="(item, index) in topList" :index="index" :key="item.id">
					<view class="topCardItem">
						<view class="topCardItemBorder" :style="{'border-right':index<2?'#8799a3 solid 1rpx':'0rpx'}">
							<text class="count"
								:style="{'color':index==chooseForm?'#ff0000':'#0081ff','fontSize':index==chooseForm?'65rpx':'50rpx'}">{{item.count}}</text>
							<text class="tips"
								:style="{'color':index==chooseForm?'#ff0000':'#0081ff','fontSize':index==chooseForm?'28rpx':'','fontWeight':index==chooseForm?'bolder':''}">{{item.tips}}</text>
						</view>
					</view>
				</uni-grid-item>
			</uni-grid>
		</view>
		<view class="searchBox">
			<uni-search-bar v-model="searchValue" placeholder="请输入要搜索的内容" bgColor="#ffffff" :focus="false"
				@confirm="searchClick">
			</uni-search-bar>
		</view>
		<view v-show="chooseForm==0" v-for="(item,index) in unauditedList" :key="item.id" class="formCard">
			<!-- <uni-transition custom-class="transition" :duration=500 :mode-class="item.modeClass" :show="item.show"> -->
				<uni-card style="box-shadow: 5rpx 5rpx 15rpx #00ffff" title="海运单" :subTitle="item.shippingContractNo"
					:extra="item.carrierCompanyName">
					<view class="cardContent">
						<uni-row style="width: 100%;">
							<uni-col :span="8">
								集装箱号 :
							</uni-col>
							<uni-col :span="16">
								{{item.containerNo}}
							</uni-col>
						</uni-row>
						<uni-row style="width: 100%;">
							<uni-col :span="8">
								铅封号 :
							</uni-col>
							<uni-col :span="16">
								{{item.sealNo}}
							</uni-col>
						</uni-row>
						<uni-row style="width: 100%;">
							<uni-col :span="8">
								总费用 :
							</uni-col>
							<uni-col :span="16">
								{{item.expenses}}
							</uni-col>
						</uni-row>
					</view>
					<view class="auditStatusGroup">
						<view v-for="(statusItem,statusIndex) in item.shippingDirector" :key="statusItem.userId"
							class="auditStatusItem">
							<view>{{statusItem.nickName}}</view>
							<view v-show="statusIndex==0">
								<uni-icons :style="'margin-left:15rpx'"
									:type="statusItem.state == null ? '' : 'checkmarkempty'"
									size="24" color="#0081ff"></uni-icons>
							</view>
							<view v-show="statusIndex==1">
								<uni-icons :style="'margin-left:15rpx'"
									:type="statusItem.state == null ? '' : 'checkmarkempty'"
									size="24" color="#0081ff"></uni-icons>
							</view>
							<view v-show="statusIndex==2">
								<uni-icons :style="'margin-left:15rpx'"
									:type="statusItem.state == null ? '' : 'checkmarkempty'"
									size="24" color="#0081ff"></uni-icons>
							</view>
						</view>
					</view>
					<view slot="actions" class="actionGroup">
						<view class="actionGroupItem" @tap="actionsClick('pass',item,index)">
							<button class="buttonGroup" type="primary">通过</button>
						</view>
						<view class="actionGroupItem" @tap="actionsClick('more',item,index)">
							<button class="buttonGroup">详情</button>
						</view>
					</view>
				</uni-card>
			<!-- </uni-transition> -->
		</view>
		<view v-show="chooseForm==1" v-for="(item,index) in auditedList" :key="item.id" class="formCard">
			<uni-card style="box-shadow: 5rpx 5rpx 15rpx #00ffff" title="海运单" :subTitle="item.shippingContractNo"
				:extra="item.carrierCompanyName">
				<view class="cardContent">
					<uni-row style="width: 100%;">
						<uni-col :span="8">
							集装箱号 :
						</uni-col>
						<uni-col :span="16">
							{{item.containerNo}}
						</uni-col>
					</uni-row>
					<uni-row style="width: 100%;">
						<uni-col :span="8">
							铅封号 :
						</uni-col>
						<uni-col :span="16">
							{{item.sealNo}}
						</uni-col>
					</uni-row>
					<uni-row style="width: 100%;">
						<uni-col :span="8">
							总费用 :
						</uni-col>
						<uni-col :span="16">
							{{item.expenses}}
						</uni-col>
					</uni-row>
				</view>
				<view class="auditStatusGroup">
					<view v-for="(statusItem,statusIndex) in item.shippingDirector" :key="statusItem.userId"
						class="auditStatusItem">
						<view>{{statusItem.nickName}}</view>
						<view v-show="statusIndex==0">
							<uni-icons :style="'margin-left:15rpx'"
								:type="statusItem.state == null ? '' : 'checkmarkempty'"
								size="24" color="#0081ff"></uni-icons>
						</view>
						<view v-show="statusIndex==1">
							<uni-icons :style="'margin-left:15rpx'"
								:type="statusItem.state == null ? '' : 'checkmarkempty'"
								size="24" color="#0081ff"></uni-icons>
						</view>
						<view v-show="statusIndex==2">
							<uni-icons :style="'margin-left:15rpx'"
								:type="statusItem.state == null ? '' : 'checkmarkempty'"
								size="24" color="#0081ff"></uni-icons>
						</view>
					</view>
				</view>
				<view slot="actions" class="actionGroup">
					<view class="actionGroupItem" @tap="actionsClick('more',item,index)">
						<button class="buttonGroup">详情</button>
					</view>
				</view>
			</uni-card>
		</view>
		<view v-show="chooseForm==2" v-for="(item,index) in completedList" :key="item.id" class="formCard">
			<uni-card style="box-shadow: 5rpx 5rpx 15rpx #00ffff" title="海运单" :subTitle="item.shippingContractNo"
				:extra="item.carrierCompanyName">
				<view class="cardContent">
					<uni-row style="width: 100%;">
						<uni-col :span="8">
							集装箱号 :
						</uni-col>
						<uni-col :span="16">
							{{item.containerNo}}
						</uni-col>
					</uni-row>
					<uni-row style="width: 100%;">
						<uni-col :span="8">
							铅封号 :
						</uni-col>
						<uni-col :span="16">
							{{item.sealNo}}
						</uni-col>
					</uni-row>
					<uni-row style="width: 100%;">
						<uni-col :span="8">
							总费用 :
						</uni-col>
						<uni-col :span="16">
							{{item.expenses}}
						</uni-col>
					</uni-row>
				</view>
				<view slot="actions" class="actionGroup">
					<view class="actionGroupItem" @tap="actionsClick('more',item,index)">
						<button class="buttonGroup">详情</button>
					</view>
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
				topList: [{
						id:0,
						count: 0,
						tips: "待审批",
						current:1,
						page:5
					},
					{
						id:1,
						count: 0,
						tips: "已审批",
						current:1,
						page:5
					},
					{
						id:2,
						count: 0,
						tips: "已完成",
						current:1,
						page:5
					}
				],
				chooseForm: 0,
				unauditedList: [],
				auditedList: [],
				completedList: []
			}
		},
		mounted() {
			//页面加载完成，获取本地存储的用户信息
			const userData = uni.getStorageSync('userInfo');
			if (userData) {
				this.user.userId = userData.userId;
				this.user.nickName = userData.nickName;
				this.getContractData();
			}
		},
		// onLoad(data) {
		// 	console.log(data);
		// 	if (data.chooseForm == 1) {
		// 		this.chooseForm = 1;
		// 	} else if (data.chooseForm == 2) {
		// 		this.chooseForm = 2;
		// 	}
		// },
		onNavigationBarButtonTap(){
			uni.switchTab({
				url:"/pages/MainInterface/audit"
			})
		},
		onReachBottom() {
			if (this.chooseForm == 0) {
				this.getUnAuditedData();
			} else if (this.chooseForm == 1) {
				this.getAuditedData();
			} else {
				this.getCompletedData();
			}
		},
		methods: {
			getContractData(){
				// 获取未审批物流付款单
				this.$request({
					url: '/shippingContract/getDirectorSC',
					data: {
						current: this.topList[0].current,
						page: this.topList[0].page,
						userId: this.user.userId,
						type: 0,
					}
				}).then(res=>{
					if(res.code==200){
						this.unauditedList=res.data.records;
						this.topList[0].count=res.data.total;
						console.log(this.unauditedList);
					}
				},
				err=>{
					uni.showModal({
						content: "请求服务失败",
						showCancel: false
					})
				})
				// 获取已审批的物流付款单
				this.$request({
					url: '/shippingContract/getDirectorSC',
					data: {
						current: this.topList[1].current,
						page: this.topList[1].page,
						userId: this.user.userId,
						type: 1,
					}
				}).then(res=>{
					if(res.code==200){
						this.auditedList=res.data.records;
						this.topList[1].count=res.data.total;
						console.log(this.auditedList);
					}
				},
				err=>{
					uni.showModal({
						content: "请求服务失败",
						showCancel: false
					})
				})
				// 获取已完成的物流付款单
				this.$request({
					url: '/shippingContract/getDirectorSC',
					data: {
						current: this.topList[2].current,
						page: this.topList[2].page,
						userId: this.user.userId,
						type: 2,
					}
				}).then(res=>{
					if(res.code==200){
						this.completedList=res.data.records;
						this.topList[2].count=res.data.total;
						console.log(this.completedList);
					}
				},
				err=>{
					uni.showModal({
						content: "请求服务失败",
						showCancel: false
					})
				})
			},
			getUnAuditedData(){
				if(this.unauditedList.length==this.topList[0].count){
					uni.showModal({
						content: "暂无更多数据",
						showCancel: false
					})
				}else{
					this.topList[0].current=this.topList[0].current+1,
					this.topList[0].page=this.topList[0].page+5,
					// 获取未审批采购付款单
					this.$request({
						url: '/shippingContract/getDirectorSC',
						data: {
							current: this.topList[0].current,
							page: this.topList[0].page,
							userId: this.user.userId,
							type: 0,
						}
					}).then(res=>{
						if(res.code==200){
							this.unauditedList=[...this.unauditedList, ...res.data.records];
						}
					},
					err=>{
						uni.showModal({
							content: "请求服务失败",
							showCancel: false
						})
					})
				}
			},
			getAuditedData(){
				if(this.unauditedList.length==this.topList[0].count){
					uni.showModal({
						content: "暂无更多数据",
						showCancel: false
					})
				}else{
					this.topList[1].current=this.topList[1].current+1,
					this.topList[1].page=this.topList[1].page+5,
					// 获取未审批采购付款单
					this.$request({
						url: '/shippingContract/getDirectorSC',
						data: {
							current: this.topList[1].current,
							page: this.topList[1].page,
							userId: this.user.userId,
							type: 1,
						}
					}).then(res=>{
						if(res.code==200){
							if(this.auditedList.length==res.data.total){
								uni.showModal({
									content: "暂无更多数据",
									showCancel: false
								})
							}else{
								this.auditedList=[...this.auditedList, ...res.data.records];
							}
						}
					},
					err=>{
						uni.showModal({
							content: "请求服务失败",
							showCancel: false
						})
					})
				}
			},
			getCompletedData(){
				if(this.unauditedList.length==this.topList[0].count){
					uni.showModal({
						content: "暂无更多数据",
						showCancel: false
					})
				}else{
					this.topList[2].current=this.topList[2].current+1,
					this.topList[2].page=this.topList[2].page+5,
					// 获取未审批采购付款单
					this.$request({
						url: '/shippingContract/getDirectorSC',
						data: {
							current: this.topList[2].current,
							page: this.topList[2].page,
							userId: this.user.userId,
							type: 2,
						}
					}).then(res=>{
						if(res.code==200){
							if(this.completedList.length==res.data.total){
								uni.showModal({
									content: "暂无更多数据",
									showCancel: false
								})
							}else{
								this.completedList=[...this.completedList, ...res.data.records];
							}
						}
					},
					err=>{
						uni.showModal({
							content: "请求服务失败",
							showCancel: false
						})
					})
				}
			},
			topCardClick(e) {
				this.chooseForm = e.detail.index;
			},
			searchClick(res) {
				uni.navigateTo({
					// 普通参数传输
					url: '/pages/search/searchShipping?searchWord=' + res.value
				})
			},
			actionsClick(result, item, index) {
				if (result == "pass") {
					let that=this;
					uni.showModal({
						content: "您确定要‘通过’该单吗？",
						showCancel: true,
						success(res) {
							if (res.confirm) {
								that.$request({
									url: '/shippingContract/changeDirectorState',
									data: {
										shippingContractNo: item.shippingContractNo,
										userId: that.user.userId,
									}
								}).then(res => {
									if (res.code == 200) {
										if (res.data == 1) {
											that.unauditedList.splice(index, 1);
											that.getContractData();
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
					uni.navigateTo({
						// 普通参数传输
						url: '/pages/detail/shippingDetail?contractId=' + item.id
					})
				}
			},
		}
	}
</script>

<style>
	.topBackGround {
		z-index: 100;
		background-repeat: no-repeat;
		background-size: 100%;
		background-position-y: 0px;
		background-image: url(/static/UIImages/OA.png);
		margin-bottom: 65rpx;
	}

	.nullBG {
		height: 330rpx;
	}

	.topCard {
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

	.topCardItem {
		height: 150rpx;
		border-radius: 50rpx;
		flex: 1;
	}

	.topCardItemBorder {
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

	.formCard {
		/* margin-top: 90rpx; */
	}

	.cardContent {
		display: flex;
		align-items: center;
		flex-direction: column;
		justify-content: center;
	}

	.auditStatusGroup {
		width: 100%;
		display: flex;
		align-items: center;
		flex-direction: row;
		justify-content: center;
		border-top: #DCDCDC solid 1rpx;
		margin-top: 20rpx;
	}

	.auditStatusItem {
		width: 100%;
		display: flex;
		align-items: center;
		flex-direction: row;
		justify-content: center;
		margin-top: 20rpx;
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
		border-top: #DCDCDC solid 1rpx;
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
