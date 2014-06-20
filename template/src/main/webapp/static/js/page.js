(function($) {
	$.search = function(options) {
		var defaults = {
			type : 'post',
			searchId : '#search_l',
			url : '',
			param : [],
			pageNo : 1,
			pageSize : 15,
			order : $('#order_l').val() != undefined ? $('#order_l').val() : '',
			orderBy : $('#orderBy_l').val() != undefined ? $('#orderBy_l')
					.val() : '',
			lightTableId : '',
			prefix : 'search',
			replace : true,
			async : true,
			result : function(data) {
			}
		};
		if (options != undefined && options.orderBy != undefined) {
			if (defaults.order == 'asc') {
				options.order = 'desc';
			} else {
				options.order = 'asc';
			}
		}
		options = $.extend(true, {}, defaults, options);
		if (options.type == 'post') {
			submitSearch(options);
		} else if (options.type == 'ajax') {
			options.type = 'post';
			if (options.lightTableId == '') {
				alert('ajax type,lightTableId can not be null');
				return false;
			}
			ajaxSearch(options, "message");
		}
	};

	$.initSearch = function(search, order, orderBy, options) {
		var defaults = {
			searchId : '#search_l',
			prefix : 'search'
		};
		options = $.extend(true, {}, defaults, options);
		if (search != '' && search != undefined) {
			var searchObjects = JSON.parse(search);
			for ( var i = 0; i < searchObjects.length; i++) {
				var name = options.prefix + '__'
						+ searchObjects[i].propertyName;
				if (searchObjects[i].condition != undefined
						&& searchObjects[i].condition != '') {
					name = name + '__' + searchObjects[i].condition;
				}
				$(options.searchId).find('[name="' + name + '"]').val(
						searchObjects[i].value);
			}
		}
		if (order != '' && orderBy != '') {
			$('#order_l').val(order);
			$('#orderBy_l').val(orderBy);
		}
	};
	$.submitFormData = function(options) {
		var createForm = function() {
			// create form
			var form = jQuery('<form  action="' + options.url
					+ '" method="post" target="_blank"></form>');
			if (options.param.length > 0) {
				for ( var i in options.param) {
					for ( var property in options.param[i]) {
						if (options.param[i].hasOwnProperty(property)) {
							jQuery(
									'<input type=\'hidden\' name=\'' + property
											+ '\' value=\''
											+ options.param[i][property]
											+ '\' />').appendTo(form);
						}
					}
				}
			}
			jQuery(form).appendTo('body');
			return form;
		};
		var form = createForm();
		form.submit();
	};

	$.submitJson = function(options) {
		var createForm = function() {
			// create form
			var form = jQuery('<form  action="' + options.url
					+ '" method="post"></form>');
			if (options.target) {
				$(form).attr("target", options.target);
			}
			for ( var property in options.data) {
				if (options.data.hasOwnProperty(property)) {
					jQuery(
							'<input type=\'hidden\' name=\'' + property
									+ '\' value=\'' + options.data[property]
									+ '\' />').appendTo(form);
				}
			}
			jQuery(form).appendTo('body');
			return form;
		};
		var form = createForm();
		form.submit();
	};
	function ajaxSearch(options, msgId) {
		if (options.showWait) {
			$('#' + getLightTableId(options.lightTableId)).parent().siblings(
					".wait-load").show();
		} else {
			$('#' + getLightTableId(options.lightTableId)).parent().parent()
					.append(
							"<div id='loading' style='text-align:center;align:center;'><img src='"
									+ absoluteContextPath
									+ "/image/loading.gif'/></div>");
			$('#' + getLightTableId(options.lightTableId)).parent().hide();
		}
		var defaults = {
			success : function(json) {
				var result = jQuery.parseJSON(json);
				if (result.returnCode == 1) {
					if (options.replace) {
						$('#' + getLightTableId(options.lightTableId)).parent()
								.html(result.content.data).show();
						$.initSearch(result.content.search,
								result.content.order, result.content.orderBy,
								options);
					}
				} else {
					showError(result.returnMsg, 'slow', 15000, msgId);
				}
				options.result(result);
				if ($("#loading").length) {
					$("#loading").remove();
				}
				$(".wait-load").hide();
			},
			error : function(data) {
				showError(data.status + " " + data.responseText, 'slow', 15000,
						msgId);
				if ($("#loading").length) {
					$("#loading").remove();
				}
				$(".wait-load").hide();
			}
		};
		options = $.extend(true, {}, jQuery.ajaxSettings, options, defaults);
		var json = searchJson(options.searchId, options.prefix);
		if (json != '') {
			options.param.push('search=' + json);
		}
		if (options.order != '' && options.orderBy != '') {
			options.param.push('order=' + options.order);
			options.param.push('orderBy=' + options.orderBy);
		}
		options.param.push('pageNo=' + options.pageNo);
		options.param.push('pageSize=' + options.pageSize);
		options.param.push('lightTableId='
				+ getLightTableId(options.lightTableId));
		options.data = options.param.join("&");
		$.ajax(options);
	}

	function submitSearch(options) {
		var createForm = function() {
			// create form
			var form = jQuery('<form  action="' + options.url
					+ '" method="post"></form>');
			if (options.param.length > 0) {
				for ( var i in options.param) {
					if (options.param.hasOwnProperty(i)) {
						for ( var property in options.param[i]) {
							if (options.param[i].hasOwnProperty(property)) {
								jQuery(
										'<input type=\'hidden\' name=\''
												+ property + '\' value=\''
												+ options.param[i][property]
												+ '\' />').appendTo(form);
							}
						}
					}
				}
			}
			jQuery(form).appendTo('body');
			return form;
		};
		var json = searchJson(options.searchId, options.prefix);
		if (json != '') {
			options.param.push({
				'search' : json
			});
		}
		if (options.order != '' && options.orderBy != '') {
			options.param.push({
				order : options.order
			});
			options.param.push({
				orderBy : options.orderBy
			});
		}
		options.param.push({
			pageNo : options.pageNo
		});
		options.param.push({
			pageSize : options.pageSize
		});
		var form = createForm();
		form.submit();
	}

	getLightTableId = function(id) {
		return "table_l_" + id;
	};

	searchJson = function(id, prefix) {
		if ($(id) != undefined) {
			var objects = [];
			$(id)
					.find('[name^=' + prefix + ']')
					.each(
							function() {
								if ($(this).attr('type') == 'checkbox'
										|| $(this).attr('type') == 'radio') {
									if (!($(this).is(':checked'))) {
										return;
									}
								}
								var name = $(this).attr('name');
								var split = name.split('__');
								var key = split[1];
								if (split.length >= 2) {
									var condition = split[2];
								}
								var val = $(this).val();
								var resultVal = [];
								if (val != '' && val != null
										&& val != undefined) {
									if (val.constructor != Array) {
										resultVal[0] = val;
									} else {
										resultVal = val;
									}

									for ( var i = 0; i < resultVal.length; i++) {
										var parse = $(this).attr('parse');
										if (parse == 'int' || parse == 'Int'
												|| parse == 'long'
												|| parse == 'Long'
												|| parse == 'short'
												|| parse == 'integer'
												|| parse == 'Integer') {
											val = parseInt(resultVal[i]);
										} else if (parse == 'float'
												|| parse == 'Float'
												|| parse == 'double'
												|| parse == 'Double') {
											val = parseFloat(resultVal[i]);
										} else if (parse == 'boolean') {
											val = resultVal[i];
										} else {
											if (parse == undefined
													|| parse.length < 1) {
												parse = 'string';
											}
											val = resultVal[i];
										}
										objects.push(new SearchObject(key,
												condition, val, parse));
									}
								}
							});
			if (objects.length > 0) {
				return JSON.stringify(objects);
			}
		}
		return '';
	}

	$.fn.submitResult = function(data, options, msgId) {
		var defaults = {
			css : '',
			opacity : 'slow',
			delay : 15000,
			replace : false,
			lightTableId : '',
			success : function(data) {
			}
		};
		options = $.extend(true, {}, defaults, options);
		var result = JSON.parse(data);
		$(this).find('.control-group').removeClass('error');
		$(this).find('.form_error_l').remove();
		$(this).find('.blur-form-error').removeClass('blur-form-error');
		if (result.returnCode == 0) {
			if (Object.prototype.toString.apply(result.content) === '[object Array]') {
				var showMessage = '';
				for ( var i = 0; i < result.content.length; i++) {
					for ( var property in result.content[i]) {
						if (property != undefined
								&& result.content[i].hasOwnProperty(property)) {
							var input = $(this).find(
									'[name="' + property + '"]');
							if (input.length > 0) {
								var parent = $(input).parents('.control-group');
								if (parent != undefined && parent.length > 0) {
									$(parent).addClass('error');
									var span = jQuery('<span class="form_error_l help-inline">'
											+ result.content[i][property]
											+ '</span> ');
									$(input).parents('.controls').append(span);
								} else {
									$(input).addClass('blur-form-error');
									showMessage = showMessage + '<br/>'
											+ result.content[i][property];
								}
							} else {
								showMessage = showMessage + '<br/>'
										+ result.content[i][property];
							}
						}
					}
				}
				if (showMessage != '') {
					showError(showMessage, 5, null, msgId);
				}

			} else {
				showError(result.content, options.opacity, options.delay, msgId);
			}
		} else {
			if (options.replace) {
				$('#' + getLightTableId(options.lightTableId)).html(
						result.content.data);
			} else {
				showSuccess(result.returnMsg, options.opacity, options.delay,
						msgId);
			}
			options.success(result);
		}
	};
})(jQuery);

function Page(pageNo, pageSize, currentPage) {
	this.pageNo = pageNo;
	this.pageSize = pageSize;
	this.currentPage = currentPage;
}

/**
 * default submit search
 */
if (Page.toPages == undefined) {
	Page.toPages = new HashMap();
}
if (Page.registerToPage == undefined) {
	Page.registerToPage = function(toPage, name) {
		Page.toPages.put(name, toPage);
		Page.current = name;
		$('.light_page').each(function() {
			var pageName = $(this).attr('page');
			if (pageName == undefined) {
				$(this).attr('page', Page.current);
			}
		});
	};
}
if (Page.prototype.toPage == undefined) {
	Page.prototype.toPage = function(current) {
		if (this.currentPage != undefined) {
			Page.current = this.currentPage;
		} else {
			var name = $(current).parent('.light_page').attr('page');
			if (name != undefined) {
				Page.current = name;
			}
		}
		this.toPage = Page.toPages.get(Page.current);
		this.toPage();
	};
}

function SearchObject(key, condition, value, type) {
	this.propertyName = key;
	this.condition = condition;
	this.value = value;
	this.type = type;
}

SearchObject.prototype.EQ = "eq";
SearchObject.prototype.LT = "lt";
SearchObject.prototype.GT = "gt";
SearchObject.prototype.LIKE = "like";

function _createMsgPage(id) {
	$("#" + id)
			.html(
					'<div id="error_message" class="alert alert-error" style="display: none;"></div>'
							+ '<div id="success_message" class="alert alert-success" style="display: none;"></div>'
							+ '<div id="info_message" class="alert alert-info" style="display: none;"></div>');
}

function showError(error, opacity, delay, id) {
	opacity = (opacity == undefined) ? 'slow' : opacity;
	delay = (delay == undefined) ? 5000 : delay;
	var msg;
	if (id) {
		_createMsgPage(id);
		msg = $("#" + id).find("#error_message");
	} else {
		msg = $('#error_message');
	}
	if (!msg.length) {
		msg = $('<div id="error_message" class="alert alert-error" style="display: none;"></div>');
		$("#" + id).append(msg);
	}
	msg.append(error);
	msg.fadeIn('slow', null);
	setTimeout(function() {
		msg.html('');
		msg.fadeOut(opacity, null);
	}, delay);
}

function showSuccess(success, opacity, delay, id) {
	opacity = (opacity == undefined) ? 'slow' : opacity;
	delay = (delay == undefined) ? 5000 : delay;
	var msg;
	if (id) {
		_createMsgPage(id);
		msg = $("#" + id).find("#success_message");
	} else {
		msg = $('#success_message');
	}
	msg.html(success);
	msg.fadeIn('slow', null);
	setTimeout(function() {
		msg.html('');
		msg.fadeOut(opacity, null);
	}, delay);
}

function showInfo(info, opacity, delay, id) {
	opacity = (opacity == undefined) ? 'slow' : opacity;
	delay = (delay == undefined) ? 5000 : delay;
	var msg;
	if (id) {
		_createMsgPage(id);
		msg = $("#" + id).find("#info_message");
	} else {
		msg = $('#info_message');
	}
	msg.html(info);
	msg.fadeIn('slow', null);
	setTimeout(function() {
		msg.html('');
		msg.fadeOut(opacity, null);
	}, delay);
}

function HashMap() {
	var obj = new Object();
	this.put = function(key, value) {
		obj[key] = value;
	};
	this.get = function(key) {
		if (obj.hasOwnProperty(key)) {
			return obj[key];
		} else {
			return null;
		}
	};
	this.contains = function(key) {
		return obj.hasOwnProperty(key)
	};
	this.remove = function(key) {
		if (obj.hasOwnProperty(key)) {
			var value = obj[key];
			delete obj[key];
			return value;
		} else {
			return null;
		}
	};
	this.size = function() {
		return Object.getOwnPropertyNames(obj).length;
	};
	this.keys = function() {
		return Object.getOwnPropertyNames(obj);
	};
	this.removeAll = function() {
		var properties = this.keys();
		for ( var i = 0; i < properties.length; i++) {
			this.remove(properties[i]);
		}
	};

}

function HashSet() {
	var present = new Object();
	var hashMap = new HashMap();
	this.put = function(key) {
		if (hashMap.contains(key)) {
			return false;
		} else {
			hashMap.put(key, present);
			return true;
		}
	};
	this.contains = function(key) {
		return hashMap.contains(key);
	};
	this.remove = function(key) {
		hashMap.remove(key);
	};
	this.size = function() {
		return hashMap.size();
	};
	this.getAll = function() {
		return hashMap.keys();
	};
	this.removeAll = function() {
		hashMap.removeAll();
	};

}

$(document).ready(function() {
	jQuery('<input type="hidden" id="order_l">').appendTo('body');
	jQuery('<input type="hidden" id="orderBy_l">').appendTo('body');
});