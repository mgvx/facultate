import { browser, element, by } from 'protractor';
export var CatalogNgPage = (function () {
    function CatalogNgPage() {
    }
    CatalogNgPage.prototype.navigateTo = function () {
        return browser.get('/');
    };
    CatalogNgPage.prototype.getParagraphText = function () {
        return element(by.css('app-root h1')).getText();
    };
    return CatalogNgPage;
}());
//# sourceMappingURL=/home/radu/files/workspaces/workspace_2017/catalog4/catalog-web/src/main/webapp/e2e/app.po.js.map