$(function(){
  $('#btn').on('click', () => {
    $.ajax({
      url: "http://zipcloud.ibsnet.co.jp/api/search?zipcode=" + $('#postcode').val(),
      dataType: 'jsonp',
    }).done((data) => {
      if (data.results) { 
        getData(data.results[0]);
      } else {
        alert('該当データが見つかりません');
      }
    }).fail((data) => {
      alert('通信に失敗しました');
    });
  });

  function getData(data) {
    $('#pref').val(data.address1);
    $('#city').val(data.address2);
    $('#address').val(data.address3);
  }
});

